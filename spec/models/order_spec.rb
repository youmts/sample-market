require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  example "factoryがvalidであること" do
    p order.errors
    p order.order_items.count
    expect(order.valid?).to be_truthy
  end

  describe "Order#fill_billing_amount" do
    let(:product_a) { create(:product, price: 800) }
    let(:product_b) { create(:product, price: 400) }

    before do
      order.order_items.clear
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

  describe "Order#delivery_date_range" do
    around do |e|
      travel_to('2019-9-16 10:00'.to_time) { e.run }
    end

    example "今日（１営業日）はNG" do
      order.delivery_date = '2019-9-16'.to_date
      expect(order.valid?).to be_falsey
    end

    example "２営業日はNG" do
      order.delivery_date = '2019-9-17'.to_date
      expect(order.valid?).to be_falsey
    end

    example "３営業日はOK" do
      order.delivery_date = '2019-9-18'.to_date
      expect(order.valid?).to be_truthy
    end

    example "金曜日はOK" do
      order.delivery_date = '2019-9-20'.to_date
      expect(order.valid?).to be_truthy
    end

    example "土曜日はNG" do
      order.delivery_date = '2019-9-21'.to_date
      expect(order.valid?).to be_falsey
    end

    example "日曜日はNG" do
      order.delivery_date = '2019-9-22'.to_date
      expect(order.valid?).to be_falsey
    end

    example "月曜日はOK" do
      order.delivery_date = '2019-9-23'.to_date
      expect(order.valid?).to be_truthy
    end

    example "１４営業日はOK" do
      order.delivery_date = '2019-10-3'.to_date
      expect(order.valid?).to be_truthy
    end

    example "１５営業日はNG" do
      order.delivery_date = '2019-10-4'.to_date
      expect(order.valid?).to be_falsey
    end
  end
end
