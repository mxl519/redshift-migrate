class CreateAppClickMismatchTable < ActiveRecord::Migration
  def change
    create_table :app_click_mismatches, :id => :false, :options => 'SORTKEY (report_partition)' do |t|
      t.timestamp :report_date, :encode => :lzo
      t.string :a_s_name, :limit => 50, :encode => :lzo
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.integer :clicks, :encode => :lzo
      t.integer :mismatched_clicks, :encode => :lzo
      t.float :mismatched_percent, :encode => :bytedict
      t.integer :unique_creatives, :encode => :lzo
    end
  end
end
