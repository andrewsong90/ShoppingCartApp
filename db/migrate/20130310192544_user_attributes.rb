class UserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :address, :text
    add_column :users, :contact, :string
  end
end
