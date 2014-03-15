class AddAccuracyToTables < ActiveRecord::Migration
  def change
    add_column :mmx_events, :tracking_accuracy, :bigint, :encode => :delta, :partitioned => :weekly
    add_column :tracking, :tracking_accuracy, :bigint, :encode => :delta
  end
end
