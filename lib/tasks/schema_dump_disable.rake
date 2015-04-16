# Disable automatic schema dumps following migration tasks

Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

Rake.application.remove_task('db:_dump')
namespace :db do
  task :_dump do
    # Overridden to do nothing
  end
end
