class AddImpressionTypeToImpressionsFinal < ActiveRecord::Migration
  def change
    add_column :impressions_final, :impression_type, "CHAR(1)", :encode => :lzo, :partitioned => :monthly
  end
end
