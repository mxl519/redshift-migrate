class AddCreatedAtToDomainModels < ActiveRecord::Migration
  def change
    add_column :clients, :created_at, :timestamp, :encode => :lzo
    add_column :advertisers, :created_at, :timestamp, :encode => :lzo
    add_column :contracts, :created_at, :timestamp, :encode => :lzo
    add_column :insertion_orders, :created_at, :timestamp, :encode => :lzo
    add_column :campaigns, :created_at, :timestamp, :encode => :lzo
  end
end
