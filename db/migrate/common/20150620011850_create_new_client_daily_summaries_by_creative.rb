class CreateNewClientDailySummariesByCreative < ActiveRecord::Migration
  def up
    execute "CREATE TABLE prototype_new_client_daily_summaries_by_creative (LIKE prototype_client_daily_summaries_by_creative);"
  end

  def down
    drop_table :prototype_new_client_daily_summaries_by_creative
  end
end
