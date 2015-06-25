class RemoveOldClientDailySummaries < ActiveRecord::Migration
  def up
    drop_table :prototype_client_daily_summaries
    drop_table :prototype_client_daily_summaries_by_creative
    drop_table :prototype_client_daily_summaries_by_location
    
    rename_table :prototype_new_client_daily_summaries, :prototype_client_daily_summaries
    rename_table :prototype_new_client_daily_summaries_by_creative, :prototype_client_daily_summaries_by_creative
    rename_table :prototype_new_client_daily_summaries_by_location, :prototype_client_daily_summaries_by_location
  end

  def down
    rename_table :prototype_client_daily_summaries, :prototype_new_client_daily_summaries
    rename_table :prototype_client_daily_summaries_by_creative, :prototype_new_client_daily_summaries_by_creative
    rename_table :prototype_client_daily_summaries_by_location, :prototype_new_client_daily_summaries_by_location

    execute "CREATE TABLE prototype_client_daily_summaries (LIKE prototype_new_client_daily_summaries);"
    execute "CREATE TABLE prototype_client_daily_summaries_by_creative (LIKE prototype_new_client_daily_summaries_by_creative);"
    execute "CREATE TABLE prototype_client_daily_summaries_by_location (LIKE prototype_new_client_daily_summaries_by_location);"
  end
end
