class CreateClientEventSummaries < ActiveRecord::Migration
  def change
    create_prototype_table :client_event_summaries, :id => false, :partitioned => :monthly,
                           :options => 'SORTKEY (client_id, report_day)' do |t|
      t.date :report_day, :encode => :runlength
      t.integer :client_id, :encode => :runlength
      t.integer :insertion_order_id, :encode => :bytedict
      t.string :insertion_order_name, :encode => :lzo
      t.integer :contract_id, :encode => :bytedict
      t.string :contract_name, :encode => :lzo
      t.decimal :latitude, :precision => 10, :scale => 7, :encode => :bytedict
      t.decimal :longitude, :precision => 10, :scale => 7, :encode => :bytedict
      t.integer :impressions, :encode => :mostly8
      t.integer :clicks, :encode => :mostly8
      t.integer :conversions, :encode => :mostly8
      t.integer :event_time, :limit => 8, :encode => :delta
    end
  end
end