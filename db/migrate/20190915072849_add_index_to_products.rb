class AddIndexToProducts < ActiveRecord::Migration[5.2]
  def change
    add_index :products, [:hid_at, :row_order]
  end
end
