class AddLocationsTargetingByBoundedByColumns < ActiveRecord::Migration
  def change
    add_column :locations, :targeting_by, :string, :limit => 126, :encode => :bytedict
    add_column :locations, :bounded_by, :string, :limit => 126, :encode => :bytedict
  end
end
