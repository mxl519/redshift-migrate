class RenameLocationScoreInMmxEvents < ActiveRecord::Migration
  def change
    # Correction of a typo, so no changes to table partitions needed
    rename_column prototype_name(:mmx_events), :location_score, :location_tier
  end
end
