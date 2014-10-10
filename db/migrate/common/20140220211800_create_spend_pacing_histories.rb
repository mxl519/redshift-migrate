require 'redshift_adapter_helper'

class CreateSpendPacingHistories < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    create_table :spend_pacing_histories_yyyymm, :id => false, :options => 'SORTKEY (report_date_in_eastern_time)' do |t|
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
    grant_select :spend_pacing_histories_yyyymm
    
    create_view :spend_pacing_histories, :partitioned => :monthly
    grant_select :spend_pacing_histories
  end
end
