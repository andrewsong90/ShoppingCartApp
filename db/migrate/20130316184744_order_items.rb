class OrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :name, :string
    add_column :order_items, :price, :float
    add_column :order_items, :quantity, :integer
    add_column :order_items, :keeper_id, :integer
  end
end
