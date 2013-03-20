class Securityfields < ActiveRecord::Migration
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    remove_column :items, :updeate
  end
end
