class ChangeContractCpmCpcDataType < ActiveRecord::Migration
  def up
    add_column :contracts, :contract_cpm_new, :decimal, precision: 13, scale: 8, :encode => :lzo
    execute "UPDATE contracts SET contract_cpm_new = contract_cpm"
    remove_column :contracts, :contract_cpm
    rename_column :contracts, :contract_cpm_new, :contract_cpm

    add_column :contracts, :contract_cpc_new, :decimal, precision: 13, scale: 8, :encode => :lzo
    execute "UPDATE contracts SET contract_cpc_new = contract_cpc"
    remove_column :contracts, :contract_cpc
    rename_column :contracts, :contract_cpc_new, :contract_cpc
  end

  def down
    add_column :contracts, :contract_cpm_new, :integer, :encode => :bytedict
    execute "UPDATE contracts SET contract_cpm_new = contract_cpm"
    remove_column :contracts, :contract_cpm
    rename_column :contracts, :contract_cpm_new, :contract_cpm

    add_column :contracts, :contract_cpc_new, :integer, :encode => :runlength
    execute "UPDATE contracts SET contract_cpc_new = contract_cpc"
    remove_column :contracts, :contract_cpc
    rename_column :contracts, :contract_cpc_new, :contract_cpc
  end
end