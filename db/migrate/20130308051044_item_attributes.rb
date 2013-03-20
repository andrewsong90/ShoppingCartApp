class ItemAttributes < ActiveRecord::Migration
  def change
    add_column :items, :sales, :integer
    add_column :items, :inStock, :integer
  end
end
