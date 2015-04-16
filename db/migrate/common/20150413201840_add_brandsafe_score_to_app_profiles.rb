class AddBrandsafeScoreToAppProfiles < ActiveRecord::Migration
  def change
    add_column :app_profiles, :brandsafe_score, :integer, :limit => 2, :encode => :bytedict, :comment => COMMENT[:brandsafe_score]
  end

  COMMENT = {
    brandsafe_score: %Q[
      Brand safe ranking on the (newer) score scale.

      Measured on a scale of 0-9 with higher being better.

      - 7-9: Recognized brand safe.
      - 6: No ranking provided yet.
      - 0: Recognized as not brand safe.

      Only apps with values 7-9 may receive bids.

      This column is not yet being filled on the `app_profiles` table.

      See `brand_safe_tier` for the old brand safe system (values are equivalent, but labelled differently).
    ]
  }
end
