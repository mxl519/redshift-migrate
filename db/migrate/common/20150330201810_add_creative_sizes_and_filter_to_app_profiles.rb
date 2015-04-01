class AddCreativeSizesAndFilterToAppProfiles < ActiveRecord::Migration
  def change
    add_column :app_profiles, :creative_sizes, :string, :encode => :lzo
    add_column :app_profiles, :filter, :boolean, :encode => :runlength, :default => false
  end
end
