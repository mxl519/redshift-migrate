# Extend CommandRecorder to handle view creation
module CommandRecorderHelper
  def create_view(*args)
    record(:create_view, args)
  end

  def drop_view(*args)
    record(:drop_view, args)
  end
  
  protected
  def invert_create_view(args)
    [:drop_view, args]
  end
  
  def invert_drop_view(args)
    [:create_view, args]
  end
end

ActiveRecord::Migration::CommandRecorder.send(:include, CommandRecorderHelper)
