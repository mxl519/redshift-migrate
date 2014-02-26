require 'redshift_adapter_helper'

class CreateInsertionOrders < ActiveRecord::Migration
  def change
    create_table :insertion_orders, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :contract, :encode => :delta
      t.string :name, :encode => :lzo
      t.timestamp :start_date, :encode => :bytedict
      t.timestamp :end_date, :encode => :bytedict
      t.integer :bid_frequency, :encode => :mostly8
      t.string :clicks_map_url, :encode => :text255
      t.string :impressions_map_url, :encode => :text255
      t.integer :daily_impression_limit, :encode => :mostly16
      t.integer :daily_click_limit, :encode => :runlength
      t.string :state, :limit => 20, :encode => :text255
      t.integer :impression_budget, :encode => :mostly16
      t.integer :click_budget, :encode => :runlength
      t.integer :bid_priority, :encode => :mostly8
      t.boolean :auto_daily_pacing_enabled
      t.decimal :min_ctr, :precision => 5, :scale => 2, :encode => :runlength
      t.boolean :dynamic_spend_pacing
      t.string :pacing_strategies, :encode => :text255
      t.boolean :non_revenue_enabled, :encode => :runlength
      t.integer :advisory_budget, :encode => :mostly16
      t.string :optimization_type, :limit => 20, :encode => :text255
      t.decimal :min_ctr_optimization, :precision => 5, :scale => 2, :encode => :runlength
      t.decimal :min_conversion_optimization, :precision => 5, :scale => 2, :encode => :runlength
      t.string :target_strategy, :encode => :runlength
    end
    grant_select :insertion_orders
  end
end
