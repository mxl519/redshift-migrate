class CreatePrototypeSpendPacingHistories < ActiveRecord::Migration
  def change
    create_prototype_table :spend_pacing_histories, :id => false, :partitioned => :monthly,
      :options => 'SORTKEY (report_date_in_eastern_time)' do |t|
      t.date :report_date_in_eastern_time, :encode => :lzo
      t.integer :campaign_id, :encode => :delta32k
      t.integer :last_bid_frequency, :encode => :delta
      t.integer :last_daily_io_imp_total, :encode => :mostly16
      t.timestamp :time_of_last_imp_totals, :encode => :lzo
      t.timestamp :created_at, :encode => :lzo
      t.timestamp :updated_at, :encode => :lzo
      t.integer :last_io_imp_total, :encode => :lzo
      t.boolean :reset_on_next
    end
  end
end
