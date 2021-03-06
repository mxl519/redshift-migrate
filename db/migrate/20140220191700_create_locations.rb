require 'redshift_adapter_helper'

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :campaign, :encode => :delta
      t.string :name, :encode => :lzo
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longitude, :precision => 9, :scale => 6
      t.integer :radius, :encode => :mostly16
      t.string :variables, :limit => 1000, :encode => :lzo
      t.integer :max_bid, :encode => :runlength
      t.integer :tile_estimate, :encode => :mostly16
      t.string :location_type, :limit => 63, :encode => :runlength
      t.string :state, :limit => 63, :encode => :text255
      t.string :city, :limit => 63, :encode => :text255
      t.string :dma, :limit => 63, :encode => :text255
      t.references :destination, :encode => :runlength
      t.string :zipcode, :limit => 10, :encode => :text255
    end
    grant_select :locations
  end
end
