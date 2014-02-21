require 'redshift_adapter_helper'

class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts, :options => 'SORTKEY (id)' do |t|
      t.timestamp :updated_at, :null => false
      t.references :client, :encode => :bytedict
      t.string :name, :encode => :lzo
      t.string :role, :encode => :lzo
      t.string :email, :encode => :lzo
      t.string :phone, :limit => 20, :encode => :lzo
      t.string :fax, :limit => 20, :encode => :lzo
      t.string :address, :encode => :lzo
    end
    grant_select :client_contacts
  end
end
