class AddSegmentsToEvents < ActiveRecord::Migration
  def change
    add_column :clicks, :segments, :integer, :encode => :lzo, :partitioned => :monthly
    add_column :conversions, :segments, :integer, :encode => :lzo, :partitioned => :monthly
    add_column :tracking, :segments, :integer, :encode => :lzo, :partitioned => :monthly
  end
end
