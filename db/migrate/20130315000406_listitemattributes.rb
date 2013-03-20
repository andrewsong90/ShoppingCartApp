class Listitemattributes < ActiveRecord::Migration
  def change
    add_column :list_items, :quantity, :integer
    add_column :list_items, :priority, :integer
  end
end
