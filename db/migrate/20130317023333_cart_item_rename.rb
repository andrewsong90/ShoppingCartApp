class CartItemRename < ActiveRecord::Migration
  def change
    rename_table :cart_item_joins, :cart_items
  end
end
