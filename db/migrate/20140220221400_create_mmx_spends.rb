require 'redshift_adapter_helper'

class CreateMmxSpends < ActiveRecord::Migration
  def change
    create_table :mmx_spends, :options => 'DISTSTYLE KEY DISTKEY(insertion_order_id) SORTKEY (report_date, insertion_order_id)' do |t|
      t.date :report_date, :encode => :runlength, :null => false
      t.integer :insertion_order_id, :encode => :delta, :null => false
      t.integer :imps, :encode => :mostly16
      t.integer :clicks, :encode => :mostly16
      t.integer :spend
    end
    grant_select :mmx_spends
  end
end
