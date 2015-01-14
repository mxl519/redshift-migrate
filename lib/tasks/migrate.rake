namespace :db do
  # Migrate multiple clusters
  desc "db:migrate all sandbox clusters"
  task :migrate_sandbox => [:migrate_sandbox_engineering, :migrate_sandbox_ops]

  desc "db:migrate all production clusters"
  task :migrate_production => [:migrate_production_engineering, :migrate_production_ops]
  
  desc "db:rollback all sandbox clusters"
  task :rollback_sandbox => [:rollback_sandbox_engineering, :rollback_sandbox_ops]

  desc "db:rollback all production clusters"
  task :rollback_production => [:rollback_production_engineering, :rollback_production_ops]
  
  # Migrate individual clusters
  desc "db:migrate sandbox engineering"
  task :migrate_sandbox_engineering => [:set_sandbox_engineering_env, :environment] do
    migrate_cluster
  end
  
  desc "db:migrate sandbox ops"
  task :migrate_sandbox_ops => [:set_sandbox_ops_env, :environment] do
    migrate_cluster
  end
  
  desc "db:migrate production engineering"
  task :migrate_production_engineering => [:set_production_engineering_env, :environment] do
    migrate_cluster
  end
  
  desc "db:migrate production ops"
  task :migrate_production_engineering => [:set_production_ops_env, :environment] do
    migrate_cluster
  end

  # Rollback individual clusters
  desc "db:rollback sandbox engineering"
  task :rollback_sandbox_engineering => [:set_sandbox_engineering_env, :environment] do
    rollback_cluster
  end
  
  desc "db:rollback sandbox ops"
  task :rollback_sandbox_ops => [:set_sandbox_ops_env, :environment] do
    rollback_cluster
  end
  
  desc "db:rollback production engineering"
  task :rollback_production_engineering => [:set_production_engineering_env, :environment] do
    rollback_cluster
  end
  
  desc "db:rollback production ops"
  task :rollback_production_ops => [:set_production_ops_env, :environment] do
    rollback_cluster
  end
  
  # Helper methods for setting the environment  
  desc "set environment as engineering sandbox"
  task :set_sandbox_engineering_env do
    ENV['RAILS_ENV'] = 'sandbox_engineering'
  end
  
  desc "set environment as ops sandbox"
  task :set_sandbox_ops_env do
    ENV['RAILS_ENV'] = 'sandbox_ops'
  end

  desc "set environment as engineering production"
  task :set_production_engineering_env do
    ENV['RAILS_ENV'] = 'production_engineering'
  end
  
  desc "set environment as ops production"
  task :set_production_ops_env do
    ENV['RAILS_ENV'] = 'production_ops'
  end
  
  private
  def migrate_cluster
    stage = ENV['RAILS_ENV']
    puts "Migrating #{stage}..."
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[stage])
    load "#{Rails.root}/config/initializers/schema_migration.rb"
    Rake::Task['db:migrate'].execute
    puts "Finished migrating #{stage}."
  end
  
  def rollback_cluster
    stage = ENV['RAILS_ENV']
    puts "Rolling back #{stage}..."
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[stage])
    load "#{Rails.root}/config/initializers/schema_migration.rb"
    Rake::Task['db:rollback'].execute
    puts "Finished rolling back #{stage}."
  end
end
