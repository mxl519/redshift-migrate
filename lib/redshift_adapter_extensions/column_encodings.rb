# Extend RedshiftAdapter to handle column encodings
module TableDefinitionHelper
  def self.included(base)
    base.class_eval do
      alias_method_chain :column, :redshift_encoding
      private :column_with_redshift_encoding, :column_without_redshift_encoding
    end
  end

  private
  def column_with_redshift_encoding(name, type, options = {})
    column_without_redshift_encoding(name, type, options)

    column = self[name]
    column.encode = options[:encode]

    self
  end

  # Replace the factory for ColumnDefinitions to use our Redshift-specific version
  def new_column_definition(base, name, type)
    definition = EncodedColumnDefinition.new base, name, type
    @columns << definition
    @columns_hash[name] = definition
    definition
  end
end
ActiveRecord::ConnectionAdapters::RedshiftAdapter::TableDefinition.__send__(:include, TableDefinitionHelper)

module RedshiftAdapterHelper
  def self.included(base)
    base.class_eval do
      alias_method_chain :add_column_options!, :redshift_encoding
      private :add_column_options_with_redshift_encoding!, :add_column_options_without_redshift_encoding!
    end
  end

  private
  def add_column_options_with_redshift_encoding!(sql, options)
    sql << " ENCODE #{options[:encode]}" if options[:encode]
    add_column_options_without_redshift_encoding!(sql, options)
  end
end
ActiveRecord::ConnectionAdapters::RedshiftAdapter.__send__(:include, RedshiftAdapterHelper)

class EncodedColumnDefinition < ActiveRecord::ConnectionAdapters::ColumnDefinition
  attr_accessor :encode

  def to_sql
    column_sql = super
    column_sql << " ENCODE #{encode}" if encode
    column_sql
  end
end
