# Extend ActiveRecord migrations to handle views and their underlying tables
module MigrationHelper
  extend ActiveSupport::Concern

  def create_table(table_name, options = {})
    # Lazy-load the library overwriting the RedshiftAdapter,
    # because that gets lazy-loaded by Rails once the db connects
    require 'redshift_adapter_helper'
    super(table_name, options) do |td|
      yield td if block_given?
    end
  end

  def add_column(table_name, column_name, type, options = {})
    # Lazy-load the library overwriting the RedshiftAdapter,
    # because that gets lazy-loaded by Rails once the db connects
    require 'redshift_adapter_helper'
    if options[:partitioned]
      # Add column to view
      add_view_column(table_name, column_name, type, options)
      # Add column to prototype
      super(prototype_name(table_name), column_name, type, options)
    else
      super(table_name, column_name, type, options)
    end
  end
  
  def remove_column(table_name, *column_names)
    options = (column_names.last.kind_of? Hash) ? column_names.delete_at(-1) : {}
    if options[:partitioned]
      # Remove column from view
      remove_view_column(table_name, options[:partitioned], *column_names)
      # Remove column from prototype
      super(prototype_name(table_name), *column_names)
    else
      super(table_name, *column_names)
    end
  end
  
  def rename_column(table_name, column_name, new_column_name, options = {})
    if options[:partitioned]
      # Rename column in view
      rename_view_column(table_name, options[:partitioned], column_name, new_column_name)
      # Rename column in prototype
      super(prototype_name(table_name), column_name, new_column_name)
    else
      super(table_name, column_name, new_column_name)
    end
  end
  
  def add_view_column(view_name, column_name, type, options = {})
    # Lazy-load the library overwriting the RedshiftAdapter,
    # because that gets lazy-loaded by Rails once the db connects
    require 'redshift_adapter_helper'
    options = options.dup
    partitioned = extract_partitioned_option(options)
    raise "Did not understand 'partitioned' option '#{partitioned}'." unless [:weekly, :monthly, :hourly].include? partitioned
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      table_names.each { |table_name| add_column(table_name, column_name, type, options) }
    end
  end
  
  def remove_view_column(view_name, partitioned, *column_names)
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      table_names.each { |table_name| remove_column(table_name, *column_names) }
    end
  end
  
  def rename_view_column(view_name, partitioned, column_name, new_column_name)
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      table_names.each { |table_name| rename_column(table_name, column_name, new_column_name) }
    end
  end
  
  def create_view(view_name, options = {})
    # Hack for invertible change
    self.connection.create_view(view_name, options) if self.connection.respond_to? :create_view
    
    options = options.dup
    partitioned = extract_partitioned_option(options)
    
    create_view_over_recent_tables(view_name, partitioned)
  end
  
  def drop_view(view_name, options = {})
    # Hack for invertible change
    self.connection.drop_view(view_name, options) if self.connection.respond_to? :create_view

    return unless self.connection.table_exists?(view_name)
    statement = "DROP VIEW #{view_name}"
    execute(statement)
  end
  
  def grant_select(table_name)
    statement = "GRANT SELECT ON #{table_name} TO GROUP ops_group"
    execute(statement)
    statement = "GRANT SELECT ON #{table_name} TO GROUP data_scientist"
    execute(statement)
  end
  
  def create_prototype_table(table_name, options = {})
    create_table(prototype_name(table_name), options) do |td|
      yield td if block_given?
    end
  end
  
  private
  def create_view_over_recent_tables(prefix, partitioned)
    time = Time.current

    case partitioned
    when :weekly
      current_table = weekly_table_name(prefix, time)
      previous_table = weekly_table_name(prefix, time - 1.week)
    when :monthly
      current_table = monthly_table_name(prefix, time)
      previous_table = monthly_table_name(prefix, time - 1.month)
    else
      return
    end

    view_tables = []
    view_tables << current_table if self.connection.table_exists?(current_table)
    view_tables << previous_table if self.connection.table_exists?(previous_table)

    return unless view_tables.any?

    statement = "CREATE OR REPLACE VIEW #{prefix} AS " + view_tables.map{ |table| "SELECT * FROM #{table}" }.join(' UNION ALL ')
    execute(statement)
    grant_select(prefix)
  end
  
  def list_all_tables(prefix, partitioned)
    statement = "SELECT DISTINCT(tablename) FROM pg_table_def WHERE schemaname = 'public' AND tablename ~ '^#{partition_pattern(prefix, partitioned)}'"
    res = execute(statement)
    res.values.flatten
  end
  
  def update_view(view_name, options = {})
    if options[:partitioned] == :hourly
      yield
    else
      begin
        drop_view(view_name, options)
        yield
      ensure
        create_view(view_name, options)
      end
    end
  end

  # Monthly table partitions end in YYYYMM
  # Weekly table partitions end in YYYYMMDD
  def partition_pattern(prefix, partitioned)
    pattern = case partitioned
    when :hourly
      '\\\\d{10}'
    when :weekly
      '\\\\d{8}'
    when :monthly
      '\\\\d{6}'
    else
      raise "Unrecognized option for 'partitioned': #{partitioned}"
    end
    "#{prefix}_#{pattern}"
  end
  
  def prototype_name(table_name)
    "prototype_#{table_name}"
  end
  
  def extract_partitioned_option(options)
    options.delete(:partitioned).try(:to_sym)
  end
  
  def monthly_table_name(prefix, month)
    "#{prefix}_#{month.strftime('%Y%m')}"
  end
  
  def weekly_table_name(prefix, week)
    "#{prefix}_#{week.beginning_of_week(:sunday).strftime('%Y%m%d')}"
  end
end

ActiveRecord::Migration.send(:include, MigrationHelper)
