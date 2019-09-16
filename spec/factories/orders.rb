FactoryBot.define do
  factory :order do
    name { "MyString" }
    postal_code { "MyString" }
    address { "MyString" }
    phone_number { "MyString" }

    association :user

    after(:build) do |order|
      product = create(:product)
      order.order_items.build(product: product, quantity: 1, price: product.price)
    end
  end
end
