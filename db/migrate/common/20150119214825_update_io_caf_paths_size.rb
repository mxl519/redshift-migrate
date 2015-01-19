class UpdateIoCafPathsSize < ActiveRecord::Migration
  def up
  	rename_column :contracts, :io_path, :io_path_old
    add_column    :contracts, :io_path, :string, :encode => :lzo, :limit => 512
    rename_column :contracts, :caf_path, :caf_path_old
    add_column    :contracts, :caf_path, :string, :encode => :lzo, :limit => 512
    execute "update contracts set io_path=io_path_old, caf_path=caf_path_old" 
    remove_column :contracts, :io_path_old
    remove_column :contracts, :caf_path_old
  end

  def down
  end
end
