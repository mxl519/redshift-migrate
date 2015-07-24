class AddCongressionalDistrictToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :congressional_district, :string, :encode => :text255
  end
end
