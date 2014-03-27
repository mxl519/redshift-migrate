# Extend ActiveRecord migrations to handle views and their underlying tables
module MigrationHelper
  extend ActiveSupport::Concern
  
  def add_column(table_name, column_name, type, options = {})
    # Lazy-load the library overwriting the RedshiftAdapter,
    # because that gets lazy-loaded by Rails once the db connects
    require 'redshift_adapter_helper'
    if options[:partitioned]
      add_view_column(table_name, column_name, type, options)
    else
      super(table_name, column_name, type, options)
    end
  end
  
  def remove_column(table_name, *column_names)
    options = (column_names.last.kind_of? Hash) ? column_names.delete_at(-1) : {}
    if options[:partitioned]
      remove_view_column(table_name, options[:partitioned], *column_names)
    else
      super(table_name, *column_names)
    end
  end
  
  def add_view_column(view_name, column_name, type, options = {})
    # Lazy-load the library overwriting the RedshiftAdapter,
    # because that gets lazy-loaded by Rails once the db connects
    require 'redshift_adapter_helper'
    partitioned = options.delete(:partitioned).try(:to_sym)
    raise "Did not understand 'partitioned' option '#{partitioned}'." unless [:weekly, :monthly].include? partitioned
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
  
  def create_view(view_name, options = {})
    # Hack for invertible change
    self.connection.create_view(view_name) if self.connection.respond_to? :create_view
    
    partitioned = options.delete(:partitioned).try(:to_sym)
    select_statement = options[:sql] || list_all_tables(view_name, partitioned).map { |t| "SELECT * FROM #{t}\n" }.join("UNION ALL\n")
    statement = "CREATE OR REPLACE VIEW #{view_name} AS\n#{select_statement}"
    execute(statement)
  end
  
  def drop_view(view_name)
    # Hack for invertible change
    self.connection.drop_view(view_name) if self.connection.respond_to? :create_view
    
    statement = "DROP VIEW #{view_name}"
    execute(statement)
  end
  
  def grant_select(table_name)
    statement = "GRANT SELECT ON #{table_name} TO GROUP ops_group"
    execute(statement)
    statement = "GRANT SELECT ON #{table_name} TO GROUP data_scientist"
    execute(statement)
  end
  
  private
  def create_view_over_all_tables(prefix, partitioned)
    select_all_tables = list_all_tables(prefix).map { |table| "SELECT * FROM #{table}\n" }.join("UNION ALL\n")
    statement = "CREATE OR REPLACE VIEW #{prefix} AS\n#{select_all_tables}"
    exec_statement(statement)
  end
  
  def list_all_tables(prefix, partitioned)
    statement = "SELECT DISTINCT(tablename) FROM pg_table_def WHERE schemaname = 'public' AND tablename LIKE '#{partition_pattern(prefix, partitioned)}'"
    res = execute(statement)
    res.values.flatten
  end
  
  def update_view(view_name, options = {})
    drop_view(view_name)
    yield
  ensure
    create_view(view_name, options)
  end

  # Monthly table partitions end in YYYYMM
  # Weekly table partitions end in YYYYMMDD
  def partition_pattern(prefix, partitioned)
    pattern = case partitioned
    when :weekly
      Array.new(8, '_').join
    when :monthly
      Array.new(6, '_').join
    else
      raise "Unrecognized option for 'partitioned': #{partitioned}"
    end
    "#{prefix}_#{pattern}"
  end
end

ActiveRecord::Migration.send(:include, MigrationHelper)
