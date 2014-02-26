require 'redshift_adapter_helper'

class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :advertiser, :encode => :delta
      t.string :name, :encode => :lzo
      t.string :bid_type, :limit => 3, :encode => :runlength
      t.integer :contract_cpm, :encode => :bytedict
      t.integer :contract_cpc, :encode => :runlength
      t.string :domain, :encode => :text255
      t.timestamp :start_date, :encode => :bytedict
      t.timestamp :end_date, :encode => :bytedict
      t.string :channel, :limit => 50, :encode => :text255
      t.string :reach, :limit => 50, :encode => :text255
      t.string :source, :limit => 50, :encode => :text255
      t.boolean :dynamic_spend_pacing
      t.string :pacing_strategies, :encode => :text255
      t.boolean :third_party_tracking
      t.string :third_party_tracking_name, :encode => :text255
      t.boolean :alcohol_related, :encode => :runlength
      t.boolean :hybrid, :encode => :runlength
    end
    grant_select :contracts
  end
end
