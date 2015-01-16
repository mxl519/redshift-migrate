# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RedshiftMigrate::Application.initialize!

# Ignore some tables when dumping schema:
# - partitioned tables (detected by at least 4 digits at the end of the table name)
# - symmetricDS configs (managed by symmetric project, identified by 'sym_' prefix on the table name)
ActiveRecord::SchemaDumper.ignore_tables = [/_\d{4,}\Z/, /\bsym_[^\.]*/]
