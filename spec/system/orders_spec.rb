require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let(:user) { create(:user) }
  let!(:product) { create(:product) }

  before do
    sign_in user
    user.cart_items.create(product: product, quantity: 1)
  end

  example "購入できること" do
    visit(cart_path)
    click_link "購入する"

    expect(page).to have_current_path(new_order_path)

    fill_in "名前", with: "user"
    fill_in "郵便番号", with: "123-4567"
    fill_in "住所", with: "new_address"
    fill_in "電話番号", with: "1234567"
    select 2.business_days.from_now.to_date.to_s, from: "配送日"
    select "8時-12時", from: "配送時間帯"

    expect {
      click_button "購入を確定する"
    }.to change(Order, :count).by(1)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content("ありがとう")

    # ユーザの住所が書き換わること
    expect(user.reload.address).to eq "new_address"

    # カートが空になること
    visit(cart_path)
    expect(page).to have_content("カートが空です")

    # 購入履歴が参照できること
    visit(orders_path)
    click_link Order.last.id
    expect(page).to have_current_path(order_path(Order.last))
    expect(page).to have_content("new_address")
  end
end