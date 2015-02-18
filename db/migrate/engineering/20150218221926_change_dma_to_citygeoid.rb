class ChangeDmaToCitygeoid < ActiveRecord::Migration
  def change
    rename_column :prototype_daily_summaries_by_region, :dma, :city_geoid
  end
end
