class ListiteMmoreattributes < ActiveRecord::Migration
  def change
    add_column :list_items, :list_id, :integer
    add_column :list_items, :item_id, :integer
  end
end
