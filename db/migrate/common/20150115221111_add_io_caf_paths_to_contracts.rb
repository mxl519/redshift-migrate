class AddIoCafPathsToContracts < ActiveRecord::Migration
  def change
  	add_column :contracts, :io_path, :string, :encode => :lzo
  	add_column :contracts, :caf_path, :string, :encode => :lzo
  end
end
