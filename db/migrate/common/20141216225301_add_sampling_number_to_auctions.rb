class AddSamplingNumberToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :sampling_number, :integer, :encode => :lzo, :partitioned => :weekly
  end
end
