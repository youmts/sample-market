class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false, default: ""
      t.string :postal_code, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :phone_number, null: false, default: ""
      t.date :delivery_date, null: false
      t.string :delivery_time, null: false, default: ""
      t.integer :cod_charge, null: false, default: 0
      t.integer :postage, null: false, default: 0
      t.integer :tax, null: false, default: 0

      t.timestamps
    end
  end
end
