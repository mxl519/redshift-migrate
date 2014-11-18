class AddNativeFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :bids, :is_native, :boolean, :encode => :raw, :partitioned => :weekly
    add_column :bids, :device_native_seq, :string, :encode => :lzo, :partitioned => :weekly
    add_column :impressions, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :impressions, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
    add_column :win_notices, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :win_notices, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
    add_column :impressions_final, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :impressions_final, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
    add_column :clicks, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :clicks, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
    add_column :conversions, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :conversions, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
    add_column :tracking, :is_native, :boolean, :encode => :raw, :partitioned => :monthly
    add_column :tracking, :device_native_seq, :string, :encode => :lzo, :partitioned => :monthly
  end
end
