class RemoveOldPrototypesWithSuffixes < ActiveRecord::Migration
  # Clean up backwards-compatibility from CreatePrototypesWithoutSuffixes
  def up
    drop_table old_prototype_name(:bids_raw, :hourly)
    drop_table old_prototype_name(:events, :hourly)

    drop_table old_prototype_name(:auctions, :weekly)
    drop_table old_prototype_name(:bids, :weekly)
    drop_table old_prototype_name(:impressions, :monthly)
    drop_table old_prototype_name(:win_notices, :monthly)
    drop_table old_prototype_name(:impressions_final, :monthly)
    drop_table old_prototype_name(:clicks, :monthly)
    drop_table old_prototype_name(:conversions, :monthly)
    drop_table old_prototype_name(:tracking, :monthly)
    drop_table old_prototype_name(:external_events, :monthly)
    drop_table old_prototype_name(:spend_pacing_histories, :monthly)

    drop_table old_prototype_name(:daily_summaries, :monthly)
    drop_table old_prototype_name(:client_daily_summaries, :monthly)
    drop_table old_prototype_name(:client_daily_summaries_by_creative, :monthly)
    drop_table old_prototype_name(:client_daily_summaries_by_location, :monthly)
    drop_table old_prototype_name(:mapsense_events, :weekly)
    drop_table old_prototype_name(:mmx_events, :weekly)
  end

  def down
    create_prototype_table_like_prototype_without_suffix(:bids_raw, :hourly)
    create_prototype_table_like_prototype_without_suffix(:events, :hourly)

    create_prototype_table_like_prototype_without_suffix(:auctions, :weekly)
    create_prototype_table_like_prototype_without_suffix(:bids, :weekly)
    create_prototype_table_like_prototype_without_suffix(:impressions, :monthly)
    create_prototype_table_like_prototype_without_suffix(:win_notices, :monthly)
    create_prototype_table_like_prototype_without_suffix(:impressions_final, :monthly)
    create_prototype_table_like_prototype_without_suffix(:clicks, :monthly)
    create_prototype_table_like_prototype_without_suffix(:conversions, :monthly)
    create_prototype_table_like_prototype_without_suffix(:tracking, :monthly)
    create_prototype_table_like_prototype_without_suffix(:external_events, :monthly)
    create_prototype_table_like_prototype_without_suffix(:spend_pacing_histories, :monthly)

    create_prototype_table_like_prototype_without_suffix(:daily_summaries, :monthly)
    create_prototype_table_like_prototype_without_suffix(:client_daily_summaries, :monthly)
    create_prototype_table_like_prototype_without_suffix(:client_daily_summaries_by_creative, :monthly)
    create_prototype_table_like_prototype_without_suffix(:client_daily_summaries_by_location, :monthly)
    create_prototype_table_like_prototype_without_suffix(:mapsense_events, :weekly)
    create_prototype_table_like_prototype_without_suffix(:mmx_events, :weekly)
  end

  private
  def create_prototype_table_like_prototype_without_suffix(table, partitioned)
    new_prototype_name = new_prototype_name(table)
    old_prototype_name = old_prototype_name(table, partitioned)
    execute "CREATE TABLE #{old_prototype_name} (LIKE #{new_prototype_name});"
  end

  def new_prototype_name(table_name)
    "prototype_#{table_name}"
  end

  def old_prototype_name(table_name, partitioned)
    suffix = case partitioned
    when :hourly
      'yyyymmddhh'
    when :weekly
      'yyyymmdd'
    when :monthly
      'yyyymm'
    else
      raise "Unrecognized option for 'partitioned': #{partitioned}"
    end
    "prototype_#{table_name}_#{suffix}"
  end
end
