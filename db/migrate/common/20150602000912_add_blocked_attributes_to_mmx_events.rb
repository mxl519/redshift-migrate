class AddBlockedAttributesToMmxEvents < ActiveRecord::Migration
  def change
    add_column :mmx_events, :imp_0_battr, :string, :limit => 40, :partitioned => :weekly
  end
end
