# Extend RedshiftAdapter with the PostgreSQl extensions from MigrationComments

ActiveRecord::ConnectionAdapters::RedshiftAdapter.__send__(:include, MigrationComments::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
