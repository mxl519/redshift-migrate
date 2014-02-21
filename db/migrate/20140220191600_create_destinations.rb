require 'redshift_adapter_helper'

class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :campaign, :encode => :delta
      t.string :name, :encode => :lzo
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longitude, :precision => 9, :scale => 6
      t.string :address, :encode => :lzo
    end
    grant_select :destinations
  end
end
