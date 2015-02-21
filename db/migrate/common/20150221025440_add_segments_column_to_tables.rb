class AddSegmentsColumnToTables < ActiveRecord::Migration
  def change
    add_column :bids, :segments, :string, :encode => :lzo, :partitioned => :weekly
    add_column :impressions, :segments, :string, :encode => :lzo, :partitioned => :monthly
    add_column :impressions_final, :segments, :string, :encode => :lzo, :partitioned => :monthly
    add_column :win_notices, :segments, :string, :encode => :lzo, :partitioned => :monthly
  end
end
