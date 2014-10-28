class AddNativeFields < ActiveRecord::Migration
  def change
    add_column :bids_raw, :is_native, :boolean, :encode => :runlength, :partitioned => :hourly
    add_column :bids_raw, :device_native_seq, :string, :encode => :lzo, :partitioned => :hourly
  end
end
