namespace :db do
  desc "db:migrate all sandbox clusters"
  task :migrate_sandbox => :environment do
    migrate_cluster('sandbox_engineering')
    migrate_cluster('sandbox_ops')
  end

  desc "db:migrate all production clusters"
  task :migrate_production => :environment do
    migrate_cluster('production_engineering')
    migrate_cluster('production_ops')
  end
  
  private
  def migrate_cluster(cluster)
    Rails.logger.info "Migrating #{cluster}..."
    ENV['RAILS_ENV'] = cluster
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[cluster])
    load "#{Rails.root}/config/initializers/schema_migration.rb"
    Rake::Task['db:migrate'].execute
    Rails.logger.info "Finished migrating #{cluster}."
  end
end
