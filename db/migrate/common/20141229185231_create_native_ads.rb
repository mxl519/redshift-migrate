class CreateNativeAds < ActiveRecord::Migration
  def up
    create_table :native_ads, :id => false, :options => 'SORTKEY (creative_id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.integer :creative_id, :encode => :delta
      t.string :native_ad_type, :encode => :bytedict, :limit => 510
      t.string :title, :encode => :text32k, :limit => 510
      t.string :main_text, :encode => :text32k, :limit => 510
      t.string :call_to_action_text, :encode => :text32k, :limit => 510
      t.string :star_rating, :encode => :bytedict, :limit => 510
      t.string :main_image, :encode => :lzo, :limit => 510
      t.string :icon_image, :encode => :lzo, :limit => 510
    end
    grant_select :native_ads
  end

  def down
    drop_table :native_ads
  end
end
