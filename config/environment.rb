# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RedshiftMigrate::Application.initialize!

# Ignore partitioned tables when dumping schema (detected by at least 4 digits at the end of the table name)
ActiveRecord::SchemaDumper.ignore_tables = [/_\d{4,}\Z/]
