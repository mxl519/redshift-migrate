class CreateNewClientDailySummaries < ActiveRecord::Migration
  def up
    execute "CREATE TABLE prototype_new_client_daily_summaries (LIKE prototype_client_daily_summaries);"
  end

  def down
    drop_table :prototype_new_client_daily_summaries
  end
end
