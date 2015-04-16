class DocumentAppProfiles < ActiveRecord::Migration
  def up
    change_table :app_profiles do |t|
      t.change_table_comment %Q[
        Data profiles for apps and sites.

        "App" is used regardless of whether the profile is for an app or site.
      ]

      t.change_comment :id, %Q[
        Model ID.

        Autoincrementing integer, like other model IDs.

        See `tn_app_id` for joining to reporting tables.
      ]
      t.change_comment :exchange, %Q[
        Exchange that sends this app.

        The same app may appear on multiple .
      ]
      t.change_comment :a_s_id, %Q[
        Exchange-assigned app ID.

        May only be unique within the given exchange.
        Format and valid characters are determined by the exchange and vary widely.

        See `tn_app_id` for the Thinknear-assigned unique ID for App/Site.
      ]
      t.change_comment :is_app, %Q[
        App or Site flag.

        True if the profile is for an app.
        False if the profile is for a site.
      ]
      t.change_comment :tn_app_id, %Q[
        Thinknear-assigned unique app ID.

        Unlike `a_s_id`, provides a unique app id across all exchanges.
        Has a wide range of valid characters, due to incorporating exchange-provided IDs.

        Use this column for joining reporting tables with a column of the same name.
      ]
      t.change_comment :a_s_name, 'App name.'
      t.change_comment :tn_primary_category, %Q[
        Thinknear-assigned primary content category.

        Specified as IAB content categories by name.
        The lists of app-to-category assignments are not currently maintained.
      ]
      t.change_comment :tn_secondary_categories, %Q[
        Thinknear-assigned secondary content categories.

        Formatted as a comma-separated list.
        Specified as IAB content categories by name.
        The lists of app-to-category assignments are not currently maintained.
      ]
      t.change_comment :updated_at, %Q[
        Time of last change.

        CTR is updated daily, resulting in regular updates even if nothing else is changing.
      ]
      t.change_comment :brand_safe_tier, %Q[
        Brand safe ranking on the (older) tier scale.

        Measured on a scale of 1-9 with lower being better.

        - 1-3: Recognized brand safe.
        - 4: No ranking provided yet.
        - 9: Recognized as not brand safe.

        Only apps with values 1-3 may receive bids.

        See `brandsafe_score` for the new brand safe system (values are equivalent, but labelled differently).
      ]
      t.change_comment :daily_impressions, %Q[
        Impression counts broken down by day for app CTR.

        Formatted as a comma-separated list.
        Skips days with insufficient impressions, so that CTR data is preserved if we stop bidding on an app.
        Values represent the same days as stored in `daily_clicks`.
      ]
      t.change_comment :daily_clicks, %Q[
        Click counts broken down by day for app CTR.

        Formatted as a comma-separated list.
        Skips days with insufficient impressions, so that CTR data is preserved if we stop bidding on an app.
        Values represent the same days as stored in `daily_impressions`.
      ]
      t.change_comment :ctr_tier, %Q[
        CTR tier over events for this app.

        Measured on a scale of 0-10 with higher being better.

        Increments of CTR Tier are approximately equivalent to 0.1% CTR
        (e.g. CTR Tier 5 is 0.5% CTR, while CTR Tier 10 is 1.0% CTR and above)

        Calculated using a sliding window of recent days with sufficient impressions.
      ]
      t.change_comment :exploratory_confidence, %Q[
        Unused exploratory rating for CTR tier.

        This value is completely separate from the exploratory bidding probability used by venice.
        Despite its name, this value does not provide a measure of the confidence in the calculated CTR value on its own.

        Calculated using a sliding window of recent days with sufficient impressions.
      ]
      t.change_comment :created_at, 'Time of creation.'
      t.change_comment :bid_floor, %Q[
        Price optimization bid floor.

        Represents a minimum price below which we are unlikely to win impressions.

        Campaigns with default bid prices below this value will be unable to bid on this app.
      ]
      t.change_comment :bid_ceiling, %Q[
        Price optimization bid ceiling.

        Represents a maximum price above which our chance of winning impressions is unaffected,
        but our cost paid might still increase.

        Campaigns with default bid prices above this value will have their bids reduced.
      ]
      t.change_comment :px_app_bid, %Q[
        Private Exchange Bid Price.

        Used for private exchange apps where Thinknear has agreed upon a contracted price for impressions.

        All bids for this app use the specified private exchange price, regardless of campaign bid price.
      ]
      t.change_comment :creative_sizes, %Q[
        Available creative sizes based on recent auctions.

        Formatted as a comma-separated list.
        Values are `width + "x" + height` concatenated. (e.g. "320x50")
      ]
      t.change_comment :filter, %Q[
        Filtering flag.

        Represents apps that do not send valuable inventory.

        For apps with this flag set to true and any apps without an app profile, venice will ignore 90% of requests.
        Ignored requests are not available for bidding and are not logged as part of any auctions table.

        See `auctions.app_profile_filtered` for auctions affected by this filtering that passed the 10% ratio.
      ]
    end
  end

  def down
    change_table :app_profiles do |t|
      t.change_table_comment nil
      t.change_comment :id, nil
      t.change_comment :exchange, nil
      t.change_comment :a_s_id, nil
      t.change_comment :is_app, nil
      t.change_comment :tn_app_id, nil
      t.change_comment :a_s_name, nil
      t.change_comment :tn_primary_category, nil
      t.change_comment :tn_secondary_categories, nil
      t.change_comment :updated_at, nil
      t.change_comment :brand_safe_tier, nil
      t.change_comment :daily_impressions, nil
      t.change_comment :daily_clicks, nil
      t.change_comment :ctr_tier, nil
      t.change_comment :exploratory_confidence, nil
      t.change_comment :created_at, nil
      t.change_comment :bid_floor, nil
      t.change_comment :bid_ceiling, nil
      t.change_comment :px_app_bid, nil
      t.change_comment :creative_sizes, nil
      t.change_comment :filter, nil
    end
  end
end
