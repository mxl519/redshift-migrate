# Extend RedshiftAdapter to handle column encodings
module TableDefinitionHelper
  def column(name, type, options = {})
    column = self[name] || EncodedColumnDefinition.new(@base, name, type)
    if options[:limit]
      column.limit = options[:limit]
    elsif native[type.to_sym].is_a?(Hash)
      column.limit = native[type.to_sym][:limit]
    end
    column.precision = options[:precision]
    column.scale = options[:scale]
    column.default = options[:default]
    column.null = options[:null]
    column.encode = options[:encode]
    @columns << column unless @columns.include? column
    self
  end
end
ActiveRecord::ConnectionAdapters::RedshiftAdapter::TableDefinition.send(:include, TableDefinitionHelper)

class EncodedColumnDefinition < ActiveRecord::ConnectionAdapters::ColumnDefinition
  attr_accessor :encode
  
  def to_sql
    column_sql = super
    column_sql << " ENCODE #{encode}" if encode
    column_sql
  end
end
