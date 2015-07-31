class CreateEnvCaDaDataTable < ActiveRecord::Migration
  def up
    create_table :env_ca_da_data, :id => false, :options => 'SORTKEY (id, attribute_name)' do |t|
      t.string :id, :limit => 25, :null => false, :encode => :lzo
      t.string :attribute_name, :limit => 12, :null => false, :encode => :lzo
      t.decimal :value, :precision => 11, :scale => 1, :encode => :mostly32
    end
    grant_select :env_ca_da_data
  end

  def down
    drop_table :env_ca_da_data
  end
end
