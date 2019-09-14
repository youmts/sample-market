require 'rails_helper'

RSpec.describe "Shop", type: :system do
  let(:product) { create(:product) }

  shared_examples :public_shop do
    example "商品一覧が見られること" do
      product
      visit root_path

      expect(page).to have_current_path(root_path)
      expect(page).to have_content(product.name)
    end

    example "商品ページが見られること" do
      product
      visit shop_url(product)

      expect(page).to have_current_path(shop_url(product))
      expect(page).to have_content(product.name)
    end
  end

  context "ログインしていないとき" do
    include_examples :public_shop

    example "カートに追加できないこと" do
      product
      visit shop_url(product)

      expect(page).not_to have_content "カートに入れる"
    end
  end

  context "ログインしているとき" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    include_examples :public_shop

    example "カートに追加できること" do
      product
      visit shop_url(product)

      click_button "カートに入れる"

      visit cart_index_path

      expect(page).to have_content(product.name)
    end
  end
end