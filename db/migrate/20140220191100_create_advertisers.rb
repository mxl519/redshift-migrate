require 'redshift_adapter_helper'

class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :client, :encode => :delta
      t.string :name, :encode => :lzo
      t.references :manager, :encode => :bytedict
      t.references :sales_rep, :encode => :bytedict
      t.string :subcategory, :limit => 9, :encode => :bytedict
      t.string :properties, :encode => :text255
    end
    grant_select :advertisers
  end
end
