class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.text :desc
      t.timestamp :updeate

      t.timestamps
    end
  end
end
