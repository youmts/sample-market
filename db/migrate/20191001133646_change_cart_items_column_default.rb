class ChangeCartItemsColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cart_items, :quantity, from: nil, to: 0
  end
end
