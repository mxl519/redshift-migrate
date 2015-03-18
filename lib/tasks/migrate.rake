namespace :db do
  # Create user specific databases
  desc "CREATE DATABASE for user specific DBs on sandbox for the current REDSHIFT_SANDBOX_PREFIX"
  task :create_user_sandbox => [:environment] do
    if Rails.env[/production/]
      raise "Cannot create user sandbox databases in production environment: #{Rails.env}"
    end

    prefix = ENV['REDSHIFT_SANDBOX_PREFIX']
    if prefix.blank?
      raise "Cannot create user sandbox databases for blank REDSHIFT_SANDBOX_PREFIX"
    end

    databases = %w[engineering ops avails].map{ |db| "#{prefix}_#{db}" }

    conn = ActiveRecord::Base.connection
    begin
      remote_databases = conn.execute('SELECT datname FROM pg_database WHERE NOT datistemplate').values.flatten
      databases_to_create = databases - remote_databases

      databases_to_create.each do |db|
        conn.execute("CREATE DATABASE #{db}")
      end
    ensure
      conn.close()
    end
  end

  # Migrate multiple clusters
  desc "db:migrate all sandbox clusters"
  task :migrate_sandbox => [:migrate_sandbox_engineering, :migrate_sandbox_ops, :migrate_sandbox_avails]

  desc "db:migrate all production clusters"
  task :migrate_production => [:migrate_production_engineering, :migrate_production_ops, :migrate_production_avails]
  
  desc "db:rollback all sandbox clusters"
  task :rollback_sandbox => [:rollback_sandbox_engineering, :rollback_sandbox_ops, :rollback_sandbox_avails]

  # Migrate individual clusters
  desc "db:migrate sandbox engineering"
  task :migrate_sandbox_engineering => [:set_sandbox_engineering_env, :environment] do
    migrate_cluster
  end
  
  desc "db:migrate sandbox ops"
  task :migrate_sandbox_ops => [:set_sandbox_ops_env, :environment] do
    migrate_cluster
  end

  desc "db:migrate sandbox avails"
  task :migrate_sandbox_avails => [:set_sandbox_avails_env, :environment] do
    migrate_cluster
  end

  desc "db:migrate production engineering"
  task :migrate_production_engineering => [:set_production_engineering_env, :environment] do
    migrate_cluster
  end
  
  desc "db:migrate production ops"
  task :migrate_production_ops => [:set_production_ops_env, :environment] do
    migrate_cluster
  end

  desc "db:migrate production avails"
  task :migrate_production_avails => [:set_production_avails_env, :environment] do
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

  desc "db:rollback sandbox ops avails"
  task :rollback_sandbox_avails => [:set_sandbox_avails_env, :environment] do
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

  desc "db:rollback production ops avails"
  task :rollback_production_avails => [:set_production_avails_env, :environment] do
    rollback_cluster
  end

  # Check status of individual clusters
  desc "db:migrate:status sandbox engineering"
  task :migrate_status_sandbox_engineering => [:set_sandbox_engineering_env, :environment] do
    status_cluster
  end

  desc "db:migrate:status sandbox ops"
  task :migrate_status_sandbox_ops => [:set_sandbox_ops_env, :environment] do
    status_cluster
  end

  desc "db:migrate:status sandbox ops avails"
  task :migrate_status_sandbox_avails => [:set_sandbox_avails_env, :environment] do
    status_cluster
  end

  desc "db:migrate:status production engineering"
  task :migrate_status_production_engineering => [:set_production_engineering_env, :environment] do
    status_cluster
  end

  desc "db:migrate:status production ops"
  task :migrate_status_production_ops => [:set_production_ops_env, :environment] do
    status_cluster
  end

  desc "db:migrate:status production ops avails"
  task :migrate_status_production_avails => [:set_production_avails_env, :environment] do
    status_cluster
  end

  # Helper methods for setting the environment - NOT TO BE USED FOR OTHER TASKS OR FROM THE COMMAND LINE!
  desc "set environment as engineering sandbox"
  task :set_sandbox_engineering_env do
    ENV['RAILS_ENV'] = 'sandbox_engineering'
  end
  
  desc "set environment as ops sandbox"
  task :set_sandbox_ops_env do
    ENV['RAILS_ENV'] = 'sandbox_ops'
  end

  desc "set environment as ops avails sandbox"
  task :set_sandbox_avails_env do
    ENV['RAILS_ENV'] = 'sandbox_avails'
  end

  desc "set environment as engineering production"
  task :set_production_engineering_env do
    ENV['RAILS_ENV'] = 'production_engineering'
  end
  
  desc "set environment as ops production"
  task :set_production_ops_env do
    ENV['RAILS_ENV'] = 'production_ops'
  end

  desc "set environment as ops avails production"
  task :set_production_avails_env do
    ENV['RAILS_ENV'] = 'production_avails'
  end

  private
  def status_cluster
    stage = ENV['RAILS_ENV']
    puts "Checking status of #{stage}..."
    reload_connection(stage)
    puts "Migrations from: #{ActiveRecord::Migrator.migrations_paths}"
    Rake::Task['db:migrate:status'].execute
    puts "Finished checking status of #{stage}."
  end

  def migrate_cluster
    stage = ENV['RAILS_ENV']
    puts "Migrating #{stage}..."
    reload_connection(stage)
    Rake::Task['db:migrate'].execute
    puts "Finished migrating #{stage}."
  end
  
  def rollback_cluster
    stage = ENV['RAILS_ENV']
    puts "Rolling back #{stage}..."
    reload_connection(stage)
    Rake::Task['db:rollback'].execute
    puts "Finished rolling back #{stage}."
  end

  def reload_connection(stage)
    puts "STAGE = #{stage}"
    database_configuration = YAML::load(ERB.new(File.open('config/database.yml').read).result)[stage]
    puts "database = #{database_configuration['database']}"
    ActiveRecord::Base.establish_connection(database_configuration)
    load "#{Rails.root}/config/initializers/schema_migration.rb"
  end
end
