class DocumentPrototypeBids < ActiveRecord::Migration
  def up
    change_table :prototype_bids do |t|
      t.change_table_comment %Q[
        Bid events.

        Time partitions are generated from the prototype table schema.
      ]

      t.change_comment :request_id, 'Unique ID for this event.'
      t.change_comment :event_time, %Q[
        Event time as a UNIX timestamp in milliseconds.

        See `report_hour` for time-range filtering.
      ]
      t.change_comment :locale, %Q[
        Preferred Locale of the request.

        Determined from the HTTP headers of the received request or server default,
        so generally does not providing usable information on the user.
      ]
      t.change_comment :exchange, 'Exchange that sent the original request.'
      t.change_comment :event_type, %Q[
        Event type code.

        "d" for bids.
      ]
      t.change_comment :tn_bid_id, 'Unique ID shared across all events derived from a single bid.'
      t.change_comment :client_id, %Q[
        Client ID of the bidding line item.

        This column should not be used in reports, as it may be innacurate.
        Ventura models may be moved between parents above the contract level, and this field may reflect an old mapping.
        Use `bids.contract_id` and join from `contracts` and `advertisers`.

        Joins to the `clients` ventura domain table on `id`.
      ]
      t.change_comment :advertiser_id, %Q[
        Advertiser ID of the bidding line item.

        This column should not be used in reports, as it may be innacurate.
        Ventura models may be moved between parents above the contract level, and this field may reflect an old mapping.
        Use `bids.contract_id` and join from `contracts`.

        Joins to the `advertisers` ventura domain table on `id`.
      ]
      t.change_comment :contract_id, %Q[
        Contract ID of the bidding line item.

        Joins to the `contracts` ventura domain table on `id`.
      ]
      t.change_comment :insertion_order_id, %Q[
        Insertion Order ID of the bidding line item.

        Joins to the `insertion_orders` ventura domain table on `id`.
      ]
      t.change_comment :campaign_id, %Q[
        Campaign ID of the bidding line item.

        Joins to the `campaigns` ventura domain table on `id`.
      ]
      t.change_comment :creative_id, %Q[
        Creative ID of the bidding line item.

        Joins to the `creatives` ventura domain table on `id`.
      ]
      t.change_comment :location_id, %Q[
        Location ID of the bidding line item.

        NULL for line items without geofence targeting.

        Joins to the `locations` ventura domain table on `id`.
      ]
      t.change_comment :distance, %Q[
        Distance between the bidding location and the request tile in meters.

        Measured from the center of the tile or big-tile, so only approximates distance to the user at time of bid.
        Measured from the center of the location, or if a conquest campaign, the conquest destination.

        NULL if the bidding line item was based on user targeting without location targeting (GC).
      ]
      t.change_comment :categories, %Q[
        List of IAB categories of the request App or Site.

        Formatted as a comma-separated list.
      ]
      t.change_comment :bid_timestamp, 'Bid time as a UNIX timestamp in milliseconds.'
      t.change_comment :exploratory, %Q[
        Exploratory bidding flag.

        Of requests with no eligible line items due to CTR tier thresholds, a small percent are used in exploratory bidding.
        In this case, line items may ignore CTR checks to allow measuring the app's CTR rating.
        Spend on exploratory bidding is capped per insertion order.
      ]
      t.change_comment :price, %Q[
        Price charged for the impression.

        Specified as CPM price in USD.
        NULL for bids.

        See `true_bid_price` and `campaign_bid_price`.
      ]
      t.change_comment :event_tag, %Q[
        Descriptive tag provided by event trigger.

        NULL for bids.
      ]
      t.change_comment :auction_id, %Q[
        Exchange-assigned ID for the auction.

        See `tn_bid_id` for the Thinknear-assigned unique id.
      ]
      t.change_comment :true_bid_price, %Q[
        Bid price sent to exchange.

        Specified as CPM price in USD.
        Includes price optimization, price randomization, and other modifications if applicable.

        See `campaign_bid_price` for the unmodified value.
      ]
      t.change_comment :destination_id, %Q[
        Destination ID of the bidding line item.

        NULL unless lineitem uses conquest targeting.

        Joins to the `destinations` ventura domain table on `id`.
      ]
      t.change_comment :tile_id, %Q[
        String identifier of 100m-by-100m tile

        Formatted as `lat + lon` concatenated with lat and lon normalized by multiplying by 1000 and zero-padded to 6 digits.
        Tiles are approximately 100m-by-100m over most of the target range.
      ]
      t.change_comment :in_centroid, %Q[
        Centroid flag.

        Always NULL following the removal of centroid logic in May 2014.
      ]
      t.change_comment :weather_condition, %Q[
        Local weather condition.

        Expressed as a descriptive word/phrase such as 'unknown', 'cloudy', or 'sunny'.

        Weather data is fetched periodically from Weather Underground.
      ]
      t.change_comment :temperature, %Q[
        Local temperature in Farenheit.

        Weather data is fetched periodically from Weather Underground.
      ]
      t.change_comment :uv_index, %Q[
        Local UV index.

        Weather data is fetched periodically from Weather Underground.
      ]
      t.change_comment :tier, %Q[
        Brand safe ranking of the request App or Site on the (older) tier scale.

        Measured on a scale of 1-9 with lower being better.

        See `app_profiles.brand_safe_tier` for further documentation on the brand safe tier system.
        See `brandsafe_score` for the new brand safe system (values are equivalent, but labelled differently).
      ]
      t.change_comment :device_lat, %Q[
        Device latitude at time of bid.

        Invalid and NULL values are represented from the source request, except as noted below:

        - Excessively large positive or negative values are capped.
        - Values with less than 3 decimal places are replaced with NULL.
      ]
      t.change_comment :device_lon, %Q[
        Device longitude at time of bid.

        Invalid and NULL values are represented from the source request, except as noted below:

        - Excessively large positive or negative values are capped.
        - Values with less than 3 decimal places are replaced with NULL.
      ]
      t.change_comment :device_zip, 'Device zipcode at time of bid.'
      t.change_comment :location_tier, %Q[
        Thinknear-assigned location tier for received lat/lon.

        Measured on a scale of 0-9 with higher being better.

        See `location_score` for the replacement system (values are not equivalent).
      ]
      t.change_comment :bid_frequency, 'Bid frequency of the bidding line item.'
      t.change_comment :imp_0_impid, %Q[
        ID of the available impression space within this auction.

        Columns prefixed with `imp_0_` are generally derived from the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_size, %Q[
        Size of the available impression.

        Formatted as `width + "x" + height` concatentated.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_pos, %Q[
        Ad position.

        Value maps to ad positions as defined by the RTB spec.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_bidfloor, %Q[
        Requested bid floor.

        Specified as CPM price in USD.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_instl, %Q[
        Interstitial ad flag.

        1 if the ad is interstitial or full screen.
        0 otherwise.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_btype, %Q[
        Blocked creative types.

        Formatted as a comma-separated list.
        Values map to banner ad types as defined in the RTB spec.
        If blank, all types are allowed.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_battr, %Q[
        Blocked creative attributes.

        Formatted as a comma-separated list.
        Values map to creative attributes as defined in the RTB spec.
        If blank, all types are allowed.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_api, %Q[
        Supported API framework

        NULL since replacement with a list column in Dec 2013.

        See `imp_0_api_list` for the list of supported API frameworks.
      ]
      t.change_comment :device_carrier, %Q[
        Device carrier or ISP.

        Specified by name if it can be identified from the Mobile Network Code (MNC).
        Specified as the MNC otherwise.
      ]
      t.change_comment :device_type, %Q[
        Thinknear-assigned device type.

        Specified by name with a number for the OS versions, if recognized.
        May be inaccurate for native inventory.
      ]
      t.change_comment :device_ua, %Q[
        Device user agent.

        Identifies the browser/device environment, not the user.
      ]
      t.change_comment :device_cat, %Q[
        Device category.

        Values map to device types as defined in the RTB spec.
        1 is 'mobile/tablet'.
      ]
      t.change_comment :device_make, 'Device make.'
      t.change_comment :device_model, 'Device model.'
      t.change_comment :device_os, 'Device OS.'
      t.change_comment :device_osv, 'Device OS version.'
      t.change_comment :device_city, 'Exchange-reported city at time of bid.'
      t.change_comment :device_state, 'Exchange-reported state at time of bid.'
      t.change_comment :device_country, 'Exchange-reported country at time of bid.'
      t.change_comment :device_region, %Q[
        Exchange-reported region, based on geolocation data.

        Specified in ISO 3166-2 codes.
      ]
      t.change_comment :device_regionfips104, %Q[
        Exchange-reported region at time of bid.

        Specified in FIPS 10-4 codes.
      ]
      t.change_comment :device_metro, %Q[
        Exchange-reported metro code at time of bid.

        Specified in AdWords metro codes, not Nielsen DMAs.
      ]
      t.change_comment :device_gmc, %Q[
        Device GMC.

        Always NULL.
        Left over from a field on the OpenRTB 1 protocol.
      ]
      t.change_comment :device_ip, 'Device IPv4 address.'
      t.change_comment :device_ipv6, 'Device IPv6 address.'
      t.change_comment :device_macsha1, 'Device hardware MAC address, hashed with SHA1.'
      t.change_comment :device_openudid, 'Device OpenUDID.'
      t.change_comment :device_idfa, %Q[
        Device IDFA or Android Advertising ID.

        Preferred User ID for advertiser tracking on both iOS and Android.
      ]
      t.change_comment :device_androidid, %Q[
        Device hardware Android ID.

        Use of `device_idfa` is preferred when available.
      ]
      t.change_comment :device_imei, 'Device hardware IMEI.'
      t.change_comment :device_odin, 'Device hardware ODIN.'
      t.change_comment :device_didsha1, 'Device hardware DID, hashed with SHA1.'
      t.change_comment :device_didmd5, 'Device hardware DID, hashed with MD5.'
      t.change_comment :device_dpidmd5, 'Device hardware DPID, hashed with MD5.'
      t.change_comment :device_dpidsha1, 'Device hardware DPID, hashed with SHA1.'
      t.change_comment :device_dmacmd5, 'Device hardware MAC address, hashed with MD5.'
      t.change_comment :device_connectiontype, %Q[
        Device connection type.

        Values map to connection types as defined in the RTB spec.
      ]
      t.change_comment :device_language, %Q[
        Device or browser language.

        Specified as alpha-2/ISO 639-1 codes.
      ]
      t.change_comment :do_not_track, %Q[
        Do not track flag.

        1 if "do not track" is set on the browser or device.
      ]
      t.change_comment :geo_type, %Q[
        Exchange-reported geolocation type for location at time of bid.

        Values map to location types as defined in the RTB spec.
        1 is for 'GPS/Location Services'.
      ]
      t.change_comment :is_app, %Q[
        App or Site flag.

        True if the auctions are for App traffic.
        False if the auctions are for Site traffic.
      ]
      t.change_comment :a_s_id, %Q[
        Exchange-assigned app ID for the request App or Site.

        May only be unique within the given exchange.
        Format and valid characters are determined by the exchange and vary widely.

        Columns with an `a_s_` prefix are properties of the request App/Site.

        See `tn_app_id` for the Thinknear-assigned unique ID for App/Site.
      ]
      t.change_comment :a_s_name, %Q[
        App/Site name of the request App or Site.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_pid, %Q[
        Exchange-assigned Publisher ID of the request App or Site.

        May only be unique within the given exchange.
        Format and valid characters are determined by the exchange and vary widely.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_pub, %Q[
        Publisher name of the request App or Site.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_domain, %Q[
        Web domain of the request App or Site.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_page, %Q[
        Page URL of the request Site.

        NULL for App traffic.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_topcat, %Q[
        Matched IAB content category.

        The first matched IAB content category between the bidding line item's category whitelist
        and the App or Site's listed IAB categories.

        NULL if the bidding line item does not use a category whitelist.

        Columns with an `a_s_` prefix are properties of the request App/Site.

        See `categories` for the full list of IAB content categories for the App or Site.
      ]
      t.change_comment :a_s_keywords, %Q[
        Reported keywords of the request App or Site.

        Formatted as received in the request.
        May be comma-separated, space-separated, have the separators URL-encoded, or something else entirely.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :app_paid, %Q[
        Paid version flag of the request App.

        1 if the app is reported as a paid version.
      ]
      t.change_comment :app_ctr_score, 'Thinknear-generated CTR score of the request App or Site.'
      t.change_comment :brandsafe_score, %Q[
        Brand safe ranking of the request App or Site on the (newer) score scale.

        Measured on a scale of 0-9 with higher being better.

        See `app_profiles.brandsafe_score` for further documentation on the brand safe score system.
        See `tier` for the old brandsafe system (values are equivalent, but labelled differently).
      ]
      t.change_comment :tn_user_id, %Q[
        Thinknear-assigned unique user ID.

        This format has been deprecated, but `new_tn_user_id` is not yet reported on this table.

        See `segments` for the segments pulled off of the new user profile.
      ]
      t.change_comment :user_uid, %Q[
        Exchange-assigned unique user ID.

        See `tn_user_id` for the Thinknear-assigned user ID.
      ]
      t.change_comment :user_age, 'Reported user age.'
      t.change_comment :user_gender, %Q[
        Reported user gender.

        Specified as "m" or "f".
      ]
      t.change_comment :user_lat, %Q[
        Exchange-reported user home latitude.

        See `device_lat` for the value used in location targeting.
      ]
      t.change_comment :user_lon, %Q[
        Exchange-reported user home longitude.

        See `device_lon` for the value used in location targeting.
      ]
      t.change_comment :user_zip, 'Exchange-reported user home zipcode.'
      t.change_comment :user_country, 'Exchange-reported user home country.'
      t.change_comment :user_region, %Q[
        Exchange-reported user home region.

        Specified in ISO 3166-2 codes.
      ]
      t.change_comment :user_regionfips104, %Q[
        Exchange-reported user home region.

        Specified in FIPS 10-4 codes.
      ]
      t.change_comment :user_metro, %Q[
        Exchange-reported user home metro code.

        Specified in AdWords metro codes, not Nielsen DMAs.
      ]
      t.change_comment :user_city, 'Exchange-reported user home city.'
      t.change_comment :user_geo_type, %Q[
        Exchange-reported geolocation type for user home location.

        Values map to location types as defined in the RTB spec.
        1 is for 'GPS/Location Services'.
      ]
      t.change_comment :user_keywords, %Q[
        Reported keywords for the user.

        Formatted as received in the request.
        May be comma-separated, space-separated, have the separators URL-encoded, or something else entirely.
      ]
      t.change_comment :report_hour, %Q[
        Hour in which this event is included for reporting.

        May be one off from the actual event time for events near the edge of an hour.
        All reports use `report_hour` for time-range filtering for ease of handling.

        See `event_time` for the precise time of this event.
      ]
      t.change_comment :tn_primary_app_cat, %Q[
        Thinknear-assigned primary content category of the request App or Site.

        Specified as IAB content categories by name.
        The lists of app-to-category assignments are not currently maintained.
      ]
      t.change_comment :tn_secondary_app_cats, %Q[
        Thinknear-assigned secondary content categories of the request App or Site.

        Formatted as a comma-separated list.
        Specified as IAB content categories by name.
        The lists of app-to-category assignments are not currently maintained.
      ]
      t.change_comment :imp_0_api_list, %Q[
        Supported API frameworks

        Formatted as a comma-separated list.
        Values map to API frameworks as defined in the RTB spec.
        Some exchanges may define additional API values.
        If blank, no special APIs are supported.

        Columns prefixed with `imp_0_` are generally derived from part of the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :tn_app_id, %Q[
        Thinknear-assigned unique app ID for the request App or Site.

        Unlike `a_s_id`, provides a unique app id across all exchanges.
        Has a wide range of valid characters, due to incorporating exchange-provided IDs.

        Joins to the `app_profiles` ventura domain table on `tn_app_id`.
      ]
      t.change_comment :gc_matched_states, %Q[
        User profile states matching the bidding line item.

        The intersection of states in both the user profile and the bidding line item's targeting criteria.
        Formatted as a comma-separated list.
        Values are 2-character codes for US states and Canadian provinces.

        See `gc_profile_states` for the full list of states on the user profile.
      ]
      t.change_comment :gc_matched_dmas, %Q[
        User profile DMAs matching the bidding line item.

        The intersection of DMAs in both the user profile and the bidding line item's targeting criteria.
        Formatted as a comma-separated list.
        Values are Nielsen DMA integer IDs.

        See `gc_profile_dmas` for the full list of DMAs on the user profile.
      ]
      t.change_comment :gc_profile_states, %Q[
        User profile states.

        Formatted as a comma-separated list.
        Values are 2-character codes for US states and Canadian provinces.

        See `gc_profile_matched_states` for the subset of profile states matching the bidding line item's targeting.
      ]
      t.change_comment :gc_profile_dmas, %Q[
        User Profile DMAs.

        Formatted as a comma-separated list.
        Values are Nielsen DMA integer IDs.

        See `gc_profile_matched_dmas` for the subset of profile DMAs matching the bidding line item's targeting.
      ]
      t.change_comment :a_s_store_url, %Q[
        Store URL for the request App.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_version, %Q[
        App version for the request App.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :a_s_bundle, %Q[
        App bundle or package name for the request App.

        May provide a common ID across exchanges.

        Columns with an `a_s_` prefix are properties of the request App/Site.
      ]
      t.change_comment :auction_type, %Q[
        Auction type for this bid.

        Open RTB 2 defines the following values, but exchanges may define additional types:

        - 1: First price auction
        - 2: Second price auction
      ]
      t.change_comment :imp_0_display_manager, %Q[
        Name of SDK responsible for rendering ad.

        Columns prefixed with `imp_0_` are generally derived from the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_display_manager_version, %Q[
        Version of SDK responsible for rendering ad.

        Columns prefixed with `imp_0_` are generally derived from the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :imp_0_tag_id, %Q[
        Identifier for ad placement or tag for this auction.

        Columns prefixed with `imp_0_` are generally derived from the "Impression object" at `.imp[0]` of RTB requests.
      ]
      t.change_comment :a_s_tn_domain, %Q[
        Thinknear-assigned Web domain of the request App or Site.

        Attempts to parse out irregularities in formatting of the domain field from the raw requests.

        Columns with an `a_s_` prefix are properties of the request App/Site.

        See `a_s_domain` for the domain originally sent in the auction.
      ]
      t.change_comment :location_fetch_enabled, %Q[
        Location fetch flag.

        True if fetching current location will be supported in the landing page based on information in the auction.
      ]
      t.change_comment :pipeline_id, %Q[
        Available venice bidding pipelines.

        Specified as a bitflag.

        - 1: Location-targeting available only.
        - 2: User-targeting available only. (Only notes availability for user targeting, not the existence of a user profile)
        - 3: Location- and User-targeting available. (Same caveat about user profile existence)
      ]
      t.change_comment :location_score, %Q[
        Thinknear-assigned location tier for received lat/lon.

        Measured on a floating-point scale of 0-100 with higher being better.

        See `location_tier` for the older system (values are not equivalent).
      ]
      t.change_comment :competitors_count, %Q[
        Number of competing campaigns for this bid.

        Includes the campaign of the bidding line item in the count.

        See `competitor_ids` for the list of competing campaigns.
      ]
      t.change_comment :competitor_ids, %Q{
        List of other campaign IDs competing for this bid.

        Formatted as a comma-separated list with an extra preceding and trailing comma.
        For example, with the values [1, 2, 3], the list will be formatted as ",1,2,3,".
        The format was a compromise before Redshift supported "\\b" regexp word boundaries.

        Does not include the campaign id of the bidding line item.

        See `competitors_count` for the number of competing campaigns.
      }
      t.change_comment :campaign_bid_price, %Q[
        Bid price specified by campaign.

        Specified as CPM price in USD.
        This static value from the line item is modified per request before bidding.

        See `true_bid_price` for the value sent on the bid.
      ]
      t.change_comment :is_native, 'Native ad flag.'
      t.change_comment :device_native_seq, %Q[
        Sequence number of a native ad in the stream.

        Specified as a 0-indexed position, counting only ads in the stream.
        This is not the position of the ad in the overall content stream.
      ]
      t.change_comment :request_latency, 'Bidding latency in milliseconds.'
      t.change_comment :app_profile_bid_ceiling, %Q[
        Bid ceiling from Thinknear app profile.

        Part of bid price optimization.
      ]
      t.change_comment :app_profile_bid_floor, %Q[
        Bid floor from Thinknear app profile.

        Part of bid price optimization.
      ]
      t.change_comment :segments, %Q[
        List of segments on user profile at time of bidding.

        Formatted as a comma-separated list.

        See the `third_party_segment_infos` table for details of third party segments; join on `segment_id`.
        Older GC segments are mapped in ventura code, or data obtained from engineers.
      ]
    end
  end

  def down
    change_table :prototype_bids do |t|
      t.change_table_comment nil
      t.change_comment :request_id, nil
      t.change_comment :event_time, nil
      t.change_comment :locale, nil
      t.change_comment :exchange, nil
      t.change_comment :event_type, nil
      t.change_comment :tn_bid_id, nil
      t.change_comment :client_id, nil
      t.change_comment :advertiser_id, nil
      t.change_comment :contract_id, nil
      t.change_comment :insertion_order_id, nil
      t.change_comment :campaign_id, nil
      t.change_comment :creative_id, nil
      t.change_comment :location_id, nil
      t.change_comment :distance, nil
      t.change_comment :categories, nil
      t.change_comment :bid_timestamp, nil
      t.change_comment :exploratory, nil
      t.change_comment :price, nil
      t.change_comment :event_tag, nil
      t.change_comment :auction_id, nil
      t.change_comment :true_bid_price, nil
      t.change_comment :destination_id, nil
      t.change_comment :tile_id, nil
      t.change_comment :in_centroid, nil
      t.change_comment :weather_condition, nil
      t.change_comment :temperature, nil
      t.change_comment :uv_index, nil
      t.change_comment :tier, nil
      t.change_comment :device_lat, nil
      t.change_comment :device_lon, nil
      t.change_comment :device_zip, nil
      t.change_comment :location_tier, nil
      t.change_comment :bid_frequency, nil
      t.change_comment :imp_0_impid, nil
      t.change_comment :imp_0_size, nil
      t.change_comment :imp_0_pos, nil
      t.change_comment :imp_0_bidfloor, nil
      t.change_comment :imp_0_instl, nil
      t.change_comment :imp_0_btype, nil
      t.change_comment :imp_0_battr, nil
      t.change_comment :imp_0_api, nil
      t.change_comment :device_carrier, nil
      t.change_comment :device_type, nil
      t.change_comment :device_ua, nil
      t.change_comment :device_cat, nil
      t.change_comment :device_make, nil
      t.change_comment :device_model, nil
      t.change_comment :device_os, nil
      t.change_comment :device_osv, nil
      t.change_comment :device_city, nil
      t.change_comment :device_state, nil
      t.change_comment :device_country, nil
      t.change_comment :device_region, nil
      t.change_comment :device_regionfips104, nil
      t.change_comment :device_metro, nil
      t.change_comment :device_gmc, nil
      t.change_comment :device_ip, nil
      t.change_comment :device_ipv6, nil
      t.change_comment :device_macsha1, nil
      t.change_comment :device_openudid, nil
      t.change_comment :device_idfa, nil
      t.change_comment :device_androidid, nil
      t.change_comment :device_imei, nil
      t.change_comment :device_odin, nil
      t.change_comment :device_didsha1, nil
      t.change_comment :device_didmd5, nil
      t.change_comment :device_dpidmd5, nil
      t.change_comment :device_dpidsha1, nil
      t.change_comment :device_dmacmd5, nil
      t.change_comment :device_connectiontype, nil
      t.change_comment :device_language, nil
      t.change_comment :do_not_track, nil
      t.change_comment :geo_type, nil
      t.change_comment :is_app, nil
      t.change_comment :a_s_id, nil
      t.change_comment :a_s_name, nil
      t.change_comment :a_s_pid, nil
      t.change_comment :a_s_pub, nil
      t.change_comment :a_s_domain, nil
      t.change_comment :a_s_page, nil
      t.change_comment :a_s_topcat, nil
      t.change_comment :a_s_keywords, nil
      t.change_comment :app_paid, nil
      t.change_comment :app_ctr_score, nil
      t.change_comment :brandsafe_score, nil
      t.change_comment :tn_user_id, nil
      t.change_comment :user_uid, nil
      t.change_comment :user_age, nil
      t.change_comment :user_gender, nil
      t.change_comment :user_lat, nil
      t.change_comment :user_lon, nil
      t.change_comment :user_zip, nil
      t.change_comment :user_country, nil
      t.change_comment :user_region, nil
      t.change_comment :user_regionfips104, nil
      t.change_comment :user_metro, nil
      t.change_comment :user_city, nil
      t.change_comment :user_geo_type, nil
      t.change_comment :user_keywords, nil
      t.change_comment :report_hour, nil
      t.change_comment :tn_primary_app_cat, nil
      t.change_comment :tn_secondary_app_cats, nil
      t.change_comment :imp_0_api_list, nil
      t.change_comment :tn_app_id, nil
      t.change_comment :gc_matched_states, nil
      t.change_comment :gc_matched_dmas, nil
      t.change_comment :gc_profile_states, nil
      t.change_comment :gc_profile_dmas, nil
      t.change_comment :a_s_store_url, nil
      t.change_comment :a_s_version, nil
      t.change_comment :a_s_bundle, nil
      t.change_comment :auction_type, nil
      t.change_comment :imp_0_display_manager, nil
      t.change_comment :imp_0_display_manager_version, nil
      t.change_comment :imp_0_tag_id, nil
      t.change_comment :a_s_tn_domain, nil
      t.change_comment :location_fetch_enabled, nil
      t.change_comment :pipeline_id, nil
      t.change_comment :location_score, nil
      t.change_comment :competitors_count, nil
      t.change_comment :competitor_ids, nil
      t.change_comment :campaign_bid_price, nil
      t.change_comment :is_native, nil
      t.change_comment :device_native_seq, nil
      t.change_comment :request_latency, nil
      t.change_comment :app_profile_bid_ceiling, nil
      t.change_comment :app_profile_bid_floor, nil
      t.change_comment :segments, nil
    end
  end
end
