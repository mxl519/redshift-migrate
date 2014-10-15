class AddApiToCreatives < ActiveRecord::Migration
  def change
    add_column :creatives, :api, :integer, :encode => :bytedict
  end
end
