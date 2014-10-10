class AddTraffickerToAdvertiser < ActiveRecord::Migration
  def change
    add_column :advertisers, :trafficker_id, :integer, :encode => :bytedict
  end
end
