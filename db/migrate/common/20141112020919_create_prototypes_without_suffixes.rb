class CreatePrototypesWithoutSuffixes < ActiveRecord::Migration
  def up
    create_prototype_table_like_prototype_with_suffix(:bids_raw, :hourly)
    create_prototype_table_like_prototype_with_suffix(:events, :hourly)

    create_prototype_table_like_prototype_with_suffix(:auctions, :weekly)
    create_prototype_table_like_prototype_with_suffix(:bids, :weekly)
    create_prototype_table_like_prototype_with_suffix(:impressions, :monthly)
    create_prototype_table_like_prototype_with_suffix(:win_notices, :monthly)
    create_prototype_table_like_prototype_with_suffix(:impressions_final, :monthly)
    create_prototype_table_like_prototype_with_suffix(:clicks, :monthly)
    create_prototype_table_like_prototype_with_suffix(:conversions, :monthly)
    create_prototype_table_like_prototype_with_suffix(:tracking, :monthly)
    create_prototype_table_like_prototype_with_suffix(:external_events, :monthly)
    create_prototype_table_like_prototype_with_suffix(:spend_pacing_histories, :monthly)

    create_prototype_table_like_prototype_with_suffix(:daily_summaries, :monthly)
    create_prototype_table_like_prototype_with_suffix(:client_daily_summaries, :monthly)
    create_prototype_table_like_prototype_with_suffix(:client_daily_summaries_by_creative, :monthly)
    create_prototype_table_like_prototype_with_suffix(:client_daily_summaries_by_location, :monthly)
    create_prototype_table_like_prototype_with_suffix(:mapsense_events, :weekly)
    create_prototype_table_like_prototype_with_suffix(:mmx_events, :weekly)
  end

  def down
    drop_table new_prototype_name(:bids_raw)
    drop_table new_prototype_name(:events)

    drop_table new_prototype_name(:auctions)
    drop_table new_prototype_name(:bids)
    drop_table new_prototype_name(:impressions)
    drop_table new_prototype_name(:win_notices)
    drop_table new_prototype_name(:impressions_final)
    drop_table new_prototype_name(:clicks)
    drop_table new_prototype_name(:conversions)
    drop_table new_prototype_name(:tracking)
    drop_table new_prototype_name(:external_events)
    drop_table new_prototype_name(:spend_pacing_histories)

    drop_table new_prototype_name(:daily_summaries)
    drop_table new_prototype_name(:client_daily_summaries)
    drop_table new_prototype_name(:client_daily_summaries_by_creative)
    drop_table new_prototype_name(:client_daily_summaries_by_location)
    drop_table new_prototype_name(:mapsense_events)
    drop_table new_prototype_name(:mmx_events)
  end

  private
  def create_prototype_table_like_prototype_with_suffix(table, partitioned)
    new_prototype_name = new_prototype_name(table)
    old_prototype_name = old_prototype_name(table, partitioned)
    execute "CREATE TABLE #{new_prototype_name} (LIKE #{old_prototype_name});"
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
