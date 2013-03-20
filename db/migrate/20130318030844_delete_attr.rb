class DeleteAttr < ActiveRecord::Migration
  def change
    remove_column :orders, :item_hash
    remove_column :list_items, :priority
  end
end
