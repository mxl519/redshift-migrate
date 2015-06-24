class RemoveTierAndOtherColumnsFromMmxEvents < ActiveRecord::Migration
  def up
    remove_column :mmx_events, :tier, :partitioned => :weekly
    remove_column :mmx_events, :user_zip, :partitioned => :weekly
    remove_column :mmx_events, :zipcode, :partitioned => :weekly
    remove_column :mmx_events, :all_conversion, :partitioned => :weekly
    remove_column :mmx_events, :destination_id, :partitioned => :weekly
  end

  def down
    add_column :mmx_events, :tier, :integer, :limit => 2, :encode => :bytedict, :partitioned => :weekly
    add_column :mmx_events, :user_zip, :string, :limit => 10, :encode => :text255, :partitioned => :weekly
    add_column :mmx_events, :zipcode, :string, :limit => 10, :encode => :text255, :partitioned => :weekly
    add_column :mmx_events, :all_conversion, :integer, :limit => 2, :encode => :runlength, :partitioned => :weekly
    add_column :mmx_events, :destination_id, :integer, :limit => 2, :encode => :bytedict, :partitioned => :weekly
  end
end
