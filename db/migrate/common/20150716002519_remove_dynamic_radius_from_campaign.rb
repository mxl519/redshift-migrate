class RemoveDynamicRadiusFromCampaign < ActiveRecord::Migration
  def up
    remove_column :campaigns, :dynamic_radius
  end

  def down
    add_column :campaigns, :dynamic_radius, :boolean, :encode => :runlength
  end
end
