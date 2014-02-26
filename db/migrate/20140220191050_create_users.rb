require 'redshift_adapter_helper'

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => 'SORTKEY (id)' do |t|
      t.string :email, :encode => :lzo
      t.references :client, :encode => :bytedict
      t.string :name, :encode => :lzo
    end
    grant_select :users
  end
end
