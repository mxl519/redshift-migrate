require 'redshift_adapter_helper'

class CreateCreatives < ActiveRecord::Migration
  def change
    create_table :creatives, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.timestamp :updated_at, :null => false
      t.references :advertiser, :encode => :delta
      t.string :name, :encode => :lzo
      t.integer :type, :encode => :runlength
      t.string :link, :encode => :text255
      t.column :size, 'char(9)', :encode => :bytedict
      t.column :category, 'char(6)', :encode => :bytedict
      t.column :subcategory, 'char(9)', :encode => :bytedict
      t.string :properties, :encode => :text255
      t.string :tags, :limit => 4000, :encode => :text32k
      t.string :variables, :limit => 1000, :encode => :text32k
    end
    grant_select :creatives
  end
end
