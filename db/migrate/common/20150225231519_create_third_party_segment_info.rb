class CreateThirdPartySegmentInfo < ActiveRecord::Migration
  def up
    create_table :third_party_segment_infos, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.string :segment_id, :encode => :raw
      t.string :vendor_name, :encode => :bytedict
      t.string :category_name, :encode => :bytedict
      t.string :segment_name, :encode => :text32k
      t.string :vendor_segment_id, :encode => :raw
      t.decimal :cpm, :precision => 5, :scale => 3, :encode => :runlength
      t.timestamp :deleted_at, :encode => :lzo
      t.timestamp :created_at, :encode => :lzo
      t.timestamp :updated_at, :encode => :lzo
    end
  end

  def down
    drop_table :third_party_segment_infos
  end
end
