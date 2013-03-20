class UserStatusAttr < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer
  end
end
