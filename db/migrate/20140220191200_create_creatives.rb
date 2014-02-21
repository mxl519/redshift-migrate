require 'redshift_adapter_helper'

class CreateCreatives < ActiveRecord::Migration
  def change
    create_table :creatives, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :advertiser, :encode => :delta
      t.string :name, :encode => :lzo
      t.integer :ad_type, :encode => :runlength
      t.string :link, :encode => :text255
      t.string :size, :limit => 9, :encode => :bytedict
      t.string :category, :limit => 6, :encode => :bytedict
      t.string :subcategory, :limit => 9, :encode => :bytedict
      t.string :properties, :encode => :text255
      t.string :tags, :limit => 4000, :encode => :text32k
      t.string :variables, :limit => 1000, :encode => :text32k
    end
    grant_select :creatives
  end
end
