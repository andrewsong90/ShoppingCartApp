class Listdescription < ActiveRecord::Migration
  def change
    add_column :lists, :desc, :text
  end
end
