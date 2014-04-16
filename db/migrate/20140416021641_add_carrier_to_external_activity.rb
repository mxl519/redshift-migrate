class AddCarrierToExternalActivity < ActiveRecord::Migration
  def change
    add_column :external_events, :carrier, :string, :limit => 512, :encode => :lzo
  end
end
