class DropClientContacts < ActiveRecord::Migration
  def up
    drop_table :client_contacts
  end

  def down
    create_table :client_contacts, :id => false, :options => 'SORTKEY (id)' do |t|
      t.integer :id, :null => false, :encode => :delta
      t.timestamp :updated_at, :null => false
      t.references :client, :encode => :bytedict, :null => false
      t.string :name, :encode => :lzo, :null => false
      t.string :role, :encode => :lzo
      t.string :email, :encode => :lzo
      t.string :phone, :limit => 20, :encode => :lzo
      t.string :fax, :limit => 20, :encode => :lzo
      t.string :address, :encode => :lzo
    end
    grant_select :client_contacts
  end
end
