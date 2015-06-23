class RenameExploratoryConfidenceToExploratoryProbability < ActiveRecord::Migration
  def up
    rename_column :app_profiles, :exploratory_confidence, :exploratory_probability
    set_column_comment :app_profiles, :exploratory_probability, %Q[
      Exploratory probability for apps not on the global whitelist.

      Calculated using a sliding window of recent days with sufficient impressions.
      Greater weighing given to filtered apps to account for filtering.
    ]
  end

  def down
    rename_column :app_profiles, :exploratory_probability, :exploratory_confidence
    set_column_comment :app_profiles, :exploratory_confidence, %Q[
      Unused exploratory rating for CTR tier.

      This value is completely separate from the exploratory bidding probability used by venice.
      Despite its name, this value does not provide a measure of the confidence in the calculated CTR value on its own.

      Calculated using a sliding window of recent days with sufficient impressions.
    ]
  end
end
