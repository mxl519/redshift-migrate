class AddAccuracyToTables < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :mmx_events, :tracking_accuracy, :bigint, :encode => :delta, :partitioned => :weekly
    add_column :tracking, :tracking_accuracy, :bigint, :encode => :delta
  end
end
