class AddPipelineAndValidLoc < ActiveRecord::Migration
  def change
    add_column :auctions, :valid_location_within_boundary, :boolean, :encode => :runlength, :partitioned => :weekly
    add_column :bids, :pipeline_id, :integer, :limit => 2, :encode => :bytedict, :partitioned => :weekly
    add_column :impressions, :pipeline_id, :integer, :limit => 2, :encode => :bytedict, :partitioned => :monthly
    add_column :clicks, :pipeline_id, :integer, :limit => 2, :encode => :bytedict
    add_column :conversions, :pipeline_id, :integer, :limit => 2, :encode => :bytedict
    add_column :tracking, :pipeline_id, :integer, :limit => 2, :encode => :bytedict
  end
end