class AddAddressToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :address, :string, :encode => lzo
  end
end
