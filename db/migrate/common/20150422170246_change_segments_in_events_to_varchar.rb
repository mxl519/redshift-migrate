class ChangeSegmentsInEventsToVarchar < ActiveRecord::Migration
  def up
    remove_column :clicks, :segments, :partitioned => :monthly
    remove_column :conversions, :segments, :partitioned => :monthly
    remove_column :tracking, :segments, :partitioned => :monthly

    add_column :clicks, :segments, :string, :encode => :lzo, :partitioned => :monthly
    add_column :conversions, :segments, :string, :encode => :lzo, :partitioned => :monthly
    add_column :tracking, :segments, :string, :encode => :lzo, :partitioned => :monthly
  end

  def down
    remove_column :clicks, :segments, :partitioned => :monthly
    remove_column :conversions, :segments, :partitioned => :monthly
    remove_column :tracking, :segments, :partitioned => :monthly

    add_column :clicks, :segments, :integer, :encode => :lzo, :partitioned => :monthly
    add_column :conversions, :segments, :integer, :encode => :lzo, :partitioned => :monthly
    add_column :tracking, :segments, :integer, :encode => :lzo, :partitioned => :monthly
  end
end
