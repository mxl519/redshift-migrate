class AddNativeFieldsToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :is_native, :boolean, :encode => :runlength, :partitioned => :weekly
    add_column :auctions, :device_native_seq, :string, :encode => :lzo, :partitioned => :weekly
  end
end
