case ENV['RAILS_ENV']
when /engineering$/i
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common', 'db/migrate/engineering']
when /ops$/i
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common', 'db/migrate/ops']
else
  puts "Failed to load database settings because invalid RAILS_ENV given: #{ENV['RAILS_ENV']}"
  ActiveRecord::Migrator.migrations_paths = ['db/migrate/common']
end
