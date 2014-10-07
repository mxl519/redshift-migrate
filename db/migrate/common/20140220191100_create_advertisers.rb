require 'redshift_adapter_helper'

class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.timestamp :updated_at, :null => false
      t.references :client, :encode => :delta
      t.string :name, :encode => :lzo
      t.references :manager, :encode => :bytedict
      t.references :sales_rep, :encode => :bytedict
      t.column :category, 'char(6)', :encode => :bytedict
      t.column :subcategory, 'char(9)', :encode => :bytedict
    end
    grant_select :advertisers
  end
end
