class CreateCartItemJoins < ActiveRecord::Migration
  def change
    create_table :cart_item_joins do |t|

      t.timestamps
    end
  end
end
