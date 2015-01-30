class RenameCompetitorsCountColumnSampledAuctions < ActiveRecord::Migration

  def change
    rename_column :auctions_sampled, :competitor_count, :competitors_count, :partitioned => :weekly
  end

end
