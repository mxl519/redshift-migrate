class AddRegionToClientEventSummaries < ActiveRecord::Migration
  def change
    add_column :client_event_summaries, :region, :string, :partitioned => :monthly
  end
end
