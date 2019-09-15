FactoryBot.define do
  factory :order do
    name { "MyString" }
    postal_code { "MyString" }
    address { "MyString" }
    phone_number { "MyString" }

    association :user
  end
end
