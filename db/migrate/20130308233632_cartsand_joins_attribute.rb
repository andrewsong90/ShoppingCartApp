class CartsandJoinsAttribute < ActiveRecord::Migration
  def change
    add_column :cart_item_joins, :cart_id, :integer
    add_column :cart_item_joins, :item_id, :integer
  end
end
