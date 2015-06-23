class CreateNewClientDailySummariesByLocation < ActiveRecord::Migration
  def up
    execute "CREATE TABLE prototype_new_client_daily_summaries_by_location (LIKE prototype_client_daily_summaries_by_location);"
  end

  def down
    drop_table :prototype_new_client_daily_summaries_by_location
  end
end
