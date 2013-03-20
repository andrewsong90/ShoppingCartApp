class ListAttributes < ActiveRecord::Migration
  def change
    add_column :lists, :user_id, :integer
    add_column :lists, :privacy, :integer
    add_column :lists, :name, :string
  end
end
