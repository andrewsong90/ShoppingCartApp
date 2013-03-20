class ItemHash < ActiveRecord::Migration
  def change
    add_column :carts, :item_hash, :text
  end
end
