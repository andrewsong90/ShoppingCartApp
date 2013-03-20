class OrderAttributes < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :order_time, :datetime
    add_column :orders, :item_hash, :text
  end
end
