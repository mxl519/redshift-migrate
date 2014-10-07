case ENV['RAILS_ENV']
when /engineering$/i
  Rails.application.paths['db/migrate'] = ['db/migrate/common', 'db/migrate/engineering']
when /ops$/i
  Rails.application.paths['db/migrate'] = ['db/migrate/common', 'db/migrate/ops']
else
  Rails.logger.warn "Failed to load database settings because invalid RAILS_ENV given: #{ENV['RAILS_ENV']}"
  Rails.application.paths['db/migrate'] = ['db/migrate/common']
end
