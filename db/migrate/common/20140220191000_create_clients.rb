require 'redshift_adapter_helper'

class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.timestamp :updated_at, :null => false
      t.string :name, :encode => :lzo
      t.string :bucket_name, :limit => 50, :encode => :runlength
      t.string :channel, :limit => 50, :encode => :text255
      t.string :reach, :limit => 50, :encode => :text255
      t.string :source, :limit => 50, :encode => :text255
    end
    grant_select :clients
  end
end
