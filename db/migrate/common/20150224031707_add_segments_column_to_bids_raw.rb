class AddSegmentsColumnToBidsRaw < ActiveRecord::Migration
  def change
    add_column :bids_raw, :segments, :string, :encode => :lzo, :partitioned => :hourly
  end
end
