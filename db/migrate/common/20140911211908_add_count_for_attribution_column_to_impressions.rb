class AddCountForAttributionColumnToImpressions < ActiveRecord::Migration
  def change
    add_column :impressions, :count_for_attribution, :smallint, :encode => :runlength, :partitioned => :monthly
  end
end
