class DefaultItemsSales < ActiveRecord::Migration
  def change
    change_column :items, :sales, :integer, :default => 0
  end
end
