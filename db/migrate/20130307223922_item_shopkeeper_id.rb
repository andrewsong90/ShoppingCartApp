class ItemShopkeeperId < ActiveRecord::Migration
  def change
    add_column :items, :keeper_id, :integer
  end
end
