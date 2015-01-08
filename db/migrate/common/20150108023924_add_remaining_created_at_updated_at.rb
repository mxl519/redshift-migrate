class AddRemainingCreatedAtUpdatedAt < ActiveRecord::Migration
  def change
    add_column :app_profiles, :created_at, :datetime, :encode => :delta
    add_column :creatives, :created_at, :datetime, :encode => :delta
    add_column :destinations, :created_at, :datetime, :encode => :delta
    add_column :line_items, :created_at, :datetime, :encode => :delta
    add_column :locations, :created_at, :datetime, :encode => :delta
    add_column :users, :created_at, :datetime, :encode => :delta
    add_column :users, :updated_at, :datetime, :encode => :delta    
  end
end
