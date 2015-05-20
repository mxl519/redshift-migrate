class AddNewTnUserIdToImpressionsAvailsTable < ActiveRecord::Migration
  def change
    add_column :impressions_final, :new_tn_user_id, :string, :encode => :lzo, :limit => 100, :partitioned => :monthly
  end
end
