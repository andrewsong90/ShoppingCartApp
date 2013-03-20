class Defaultlistitems < ActiveRecord::Migration
  def change
    change_column :list_items, :priority, :integer, :default => 1
    change_column :list_items, :quantity, :integer, :default => 1
  end
end
