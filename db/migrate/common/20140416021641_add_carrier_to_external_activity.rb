class AddCarrierToExternalActivity < ActiveRecord::Migration
  def change
    # This migration was for an older system of managing partitioned tables
    # and is no longer compatible with the current partition helpers
  end

  private
  def original_change
    add_column :external_events, :carrier, :string, :limit => 512, :encode => :lzo
  end
end
