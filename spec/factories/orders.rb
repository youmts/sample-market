FactoryBot.define do
  factory :order do
    name { "MyString" }
    postal_code { "MyString" }
    address { "MyString" }
    phone_number { "MyString" }
    derivery_date { "2019-09-15" }
    derivery_time { "8_12" }
  end
end
