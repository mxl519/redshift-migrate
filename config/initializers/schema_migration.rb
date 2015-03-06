case ENV['RAILS_ENV']
when /engineering$/i
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common', 'db/migrate/engineering']
  Rails.application.paths['db/migrate'] = ['db/migrate/common', 'db/migrate/engineering']
when /avails$/i
  # We don't want avails to have the common migrations
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/avails']
  Rails.application.paths['db/migrate'] = ['db/migrate/avails']
when /ops$/i
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common', 'db/migrate/ops']
  Rails.application.paths['db/migrate'] = ['db/migrate/common', 'db/migrate/ops']
else
  puts "Failed to load database settings because invalid RAILS_ENV given: #{ENV['RAILS_ENV']}"
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common']
end
