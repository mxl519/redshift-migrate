
# Load the cluster list before the :environment task
require File.expand_path('config/initializers/redshift_clusters')

namespace :schemaspy do
  desc "Download required jars"
  task :download_reqs => [:environment] do
    SchemaSpy.new.download_missing_requirements
  end

  desc "Generate HTML documentation with SchemaSpy"
  task :generate => [:environment] do
    SchemaSpy.new.generate_docs(environment: ENV['RAILS_ENV'])
  end

  desc "Open HTML documentation in browser (OS X only)"
  task :open => [:environment] do
    SchemaSpy.new.open_docs(environment: ENV['RAILS_ENV'])
  end

  namespace :sandbox_all do
    sandbox_generate_tasks = REDSHIFT_SANDBOX_CLUSTERS.map{ |cluster| "schemaspy:#{cluster}:generate"}
    sandbox_open_tasks = REDSHIFT_SANDBOX_CLUSTERS.map{ |cluster| "schemaspy:#{cluster}:open"}

    desc "Generate HTML documentation with SchemaSpy for all sandbox clusters"
    task :generate => sandbox_generate_tasks

    desc "Open HTML documentation for all sandbox clusters in browser (OS X only), uses multiple browser tabs"
    task :open => sandbox_open_tasks
  end

  REDSHIFT_CLUSTERS.each do |cluster|
    namespace cluster do
      set_env_task = "db:set_#{cluster}_env"

      desc "Generate HTML documentation with SchemaSpy for #{cluster}"
      task :generate => [set_env_task, :environment] do
        Rake::Task['schemaspy:generate'].execute
      end

      desc "Open HTML documentation for #{cluster} in browser (OS X only)"
      task :open => [set_env_task, :environment] do
        Rake::Task['schemaspy:open'].execute
      end
    end
  end
end
