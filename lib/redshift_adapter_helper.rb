
# Require the RedshiftAdapter now, rather than wait for ActiveRecord to lazyload it
require 'activerecord_redshift_adapter'

require 'redshift_adapter_extensions/column_encodings'
require 'redshift_adapter_extensions/migration_comments'
