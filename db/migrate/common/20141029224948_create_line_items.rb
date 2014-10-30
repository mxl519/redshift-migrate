class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.string :name, :encode => :lzo
      t.integer :advertiser_id, :encode => :lzo
      t.integer :campaign_id, :encode => :delta
      t.integer :creative_id, :encode => :delta
      t.timestamp :updated_at, :encode => :lzo
    end
    grant_select :line_items
  end
end
