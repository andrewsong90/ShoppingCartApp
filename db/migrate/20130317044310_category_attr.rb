class CategoryAttr < ActiveRecord::Migration
  def change
    add_column :categories, :description, :text
  end
end
