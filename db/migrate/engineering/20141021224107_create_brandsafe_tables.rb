class CreateBrandsafeTables < ActiveRecord::Migration
  def change
    create_table :brandsafe_master_apps, :id => false do |t|
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.integer :brand_safe_tier, :encode => :mostly8
    end

    create_table :brandsafe_new_apps, :id => false do |t|
      t.string :tn_app_id, :limit => 100, :encode => :lzo
      t.string :a_s_name, :limit => 50, :encode => :lzo
      t.string :a_s_publisher, :limit => 70, :encode => :lzo
      t.string :a_s_domain, :limit => 80, :encode => :lzo
      t.integer :b_count, :encode => :lzo
      t.integer :tier, :encode => :mostly8
    end
  end
end
