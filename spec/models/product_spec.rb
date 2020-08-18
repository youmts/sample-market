require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  let(:order_item) do
    order = build(:order) do |o|
      o.order_items.build(product: product, price: product.price, quantity: 1)
    end
    order.save!
    order.order_items.first
  end

  describe "Product#hide" do
    example "hideの設定に従ってhid_atが設定されること" do
      product.hide = "1"
      expect(product.hid_at).not_to be nil

      product.hide = "0"
      expect(product.hid_at).to be nil

      product.hide = "1"
      expect(product.hid_at).not_to be nil

      # true("1")を再設定しても日時は変化しない
      expect {
        product.hide = "1"
      }.not_to change { product.hid_at }
    end
  end

  example "注文があったら削除できないこと" do
    order_item

    expect {
      product.destroy!
    }.to raise_error(ActiveRecord::InvalidForeignKey)
  end
end
