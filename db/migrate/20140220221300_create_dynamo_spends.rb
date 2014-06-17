require 'redshift_adapter_helper'

class CreateDynamoSpends < ActiveRecord::Migration
  def change
    create_table :dynamo_spends, :id => false, :options => 'DISTSTYLE KEY DISTKEY(o) SORTKEY (d, o)' do |t|
      t.date :d, :null => false, :encode => :runlength
      t.integer :o, :null => false, :encode => :delta
      t.integer :imps, :encode => :mostly16
      t.integer :spend
      t.integer :clicks, :encode => :mostly16
    end
    grant_select :dynamo_spends
  end
end
