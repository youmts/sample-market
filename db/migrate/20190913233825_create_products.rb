class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image
      t.integer :price, null: false
      t.text :description, null: false
      t.datetime :hid_at
      t.integer :row_order, null: false

      t.timestamps
    end
  end
end
