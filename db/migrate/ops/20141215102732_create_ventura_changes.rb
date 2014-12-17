class CreateVenturaChanges < ActiveRecord::Migration
  def up
    create_table :ventura_changes, :options => 'SORTKEY (id)' do |t|     
      t.string    :record_type, :encode => :text255
      t.integer   :record_id, :encode => :delta
      t.string    :attribute_name, :encode => :text255
      t.string    :attribute_old_value, :limit => 65535, :null => true, :encode => :lzo
      t.string    :attribute_new_value, :limit => 65535, :null => true, :encode => :lzo
      t.string    :changed_by, :null => true, :limit => 512, :encode => :text32k
      t.timestamp :created_at, :encode => :lzo
    end
    grant_select :ventura_changes
  end

  def down
    drop_table :ventura_changes
  end
end