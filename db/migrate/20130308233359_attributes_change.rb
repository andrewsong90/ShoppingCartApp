class AttributesChange < ActiveRecord::Migration
  def change
    add_column :cart_item_joins, :quantity, :integer, :default=>0
    remove_column :carts, :item_hash
  end
end
