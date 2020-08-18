require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  describe "cart_items" do
    example "cart_itemを増減できること" do
      user.add_cart!(product)
      expect(user.cart_items.first.quantity).to be 1

      user.add_cart!(product)
      expect(user.cart_items.first.quantity).to be 2

      user.remove_cart!(product)
      expect(user.cart_items.first.quantity).to be 1

      user.remove_cart!(product)
      expect(user.cart_items.find_by(product_id: product.id)).to be nil
    end
  end
end
