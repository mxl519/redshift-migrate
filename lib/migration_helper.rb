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
      super(prototype_name(table_name, options[:partitioned]), column_name, type, options)
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
      super(prototype_name(table_name, options[:partitioned]), *column_names)
    else
      super(table_name, *column_names)
    end
  end
  
  def rename_column(table_name, column_name, new_column_name, options = {})
    if options[:partitioned]
      # Rename column in view
      rename_view_column(table_name, options[:partitioned], column_name, new_column_name)
      # Rename column in prototype
      super(prototype_name(table_name, options[:partitioned]), column_name, new_column_name)
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
    raise "Did not understand 'partitioned' option '#{partitioned}'." unless [:weekly, :monthly, :daily, :hourly].include? partitioned
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      raise "No tables found for view #{view_name}!" if table_names.empty?
      table_names.each { |table_name| add_column(table_name, column_name, type, options) }
    end
  end
  
  def remove_view_column(view_name, partitioned, *column_names)
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      raise "No tables found for view #{view_name}!" if table_names.empty?
      table_names.each { |table_name| remove_column(table_name, *column_names) }
    end
  end
  
  def rename_view_column(view_name, partitioned, column_name, new_column_name)
    update_view(view_name, :partitioned => partitioned) do
      table_names = list_all_tables(view_name, partitioned)
      raise "No tables found for view #{view_name}!" if table_names.empty?
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
    partitioned = extract_partitioned_option(options)
    create_table(prototype_name(table_name, partitioned), options) do |td|
      yield td if block_given?
    end
  end
  
  private
  def create_view_over_recent_tables(prefix, partitioned)
    time = Time.current
    case partitioned
    when :hourly
      current_table = hourly_table_name(prefix, time)
      previous_table = hourly_table_name(prefix, time - 1.hour)
    when :daily
      current_table = daily_table_name(prefix, time)
      previous_table = daily_table_name(prefix, time - 1.day)
    when :weekly
      current_table = weekly_table_name(prefix, time)
      previous_table = weekly_table_name(prefix, time - 1.week)
    when :monthly
      current_table = monthly_table_name(prefix, time)
      previous_table = monthly_table_name(prefix, time - 1.month)
    else
      return
    end
    statement = "CREATE OR REPLACE VIEW #{prefix} AS SELECT * FROM #{previous_table} UNION ALL SELECT * FROM #{current_table}"
    execute(statement)
  end
  
  def list_all_tables(prefix, partitioned)
    statement = "SELECT DISTINCT(tablename) FROM pg_table_def WHERE schemaname = 'public' AND tablename ~ '^#{partition_pattern(prefix, partitioned)}'"
    res = execute(statement)
    res.values.flatten
  end
  
  def update_view(view_name, options = {})
    drop_view(view_name, options)
    yield
  ensure
    create_view(view_name, options)
    grant_select(view_name)
  end

  # Monthly table partitions end in YYYYMM
  # Weekly table partitions end in YYYYMMDD
  def partition_pattern(prefix, partitioned)
    pattern = case partitioned
    when :hourly
      '\\\\d{10}'
    when :daily, :weekly
      '\\\\d{8}'
    when :monthly
      '\\\\d{6}'
    else
      raise "Unrecognized option for 'partitioned': #{partitioned}"
    end
    "#{prefix}_#{pattern}"
  end
  
  def prototype_name(table_name, partitioned)
    suffix = case partitioned
    when :hourly
      'yyyymmddhh'
    when :daily, :weekly
      'yyyymmdd'
    when :monthly
      'yyyymm'
    else
      raise "Unrecognized option for 'partitioned': #{partitioned}"
    end
    "prototype_#{table_name}_#{suffix}"
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

  def daily_table_name(prefix, day)
    "#{prefix}_#{day.strftime('%Y%m%d')}"
  end

  def hourly_table_name(prefix, hour)
    "#{prefix}_#{hour.strftime('%Y%m%d%h')}"
  end
end

ActiveRecord::Migration.send(:include, MigrationHelper)
