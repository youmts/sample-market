require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Order#fill_billing_amount" do
    let(:product_a) { create(:product, price: 800) }
    let(:product_b) { create(:product, price: 400) }
    let(:order) { build(:order) }

    before do
      order.order_items.build(product: product_a, quantity: 4, price: product_a.price)
      order.order_items.build(product: product_b, quantity: 2, price: product_b.price)
    end

    example "計算できること" do
      order.fill_billing_amount

      expect(order.total_amount).to eq 5940
    end

    example "保存時にも計算されること" do
      expect(order.total_amount).not_to eq 5940
      order.save!

      expect(order.total_amount).to eq 5940
    end
  end
end
