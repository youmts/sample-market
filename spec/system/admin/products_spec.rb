require "rails_helper"

RSpec.describe 'admin/products', type: :system do
  let(:product) { create(:product) }
  
  context "管理者でログインしていないとき" do
    let(:admin) { create(:admin) }

    example "表示できないこと" do
      visit admin_product_path(product)
      expect(page).not_to have_current_path(admin_product_path(product))
    end
  end

  context "管理者でログインしているとき" do
    let(:admin) { create(:admin) }

    before do
      sign_in admin
    end

    example "表示できること" do
      visit admin_product_path(product)

      expect(page).to have_current_path(admin_product_path(product))
      expect(page).to have_content(product.name)
    end

    example "一覧表示できること" do
      product
      visit admin_products_path

      expect(page).to have_current_path(admin_products_path)
      expect(page).to have_content(product.name)
    end

    example "編集できること" do
      visit edit_admin_product_path(product)
      fill_in "product[name]", with: "new_name"

      click_button "commit"

      expect(page).to have_current_path admin_product_path(product)
      expect(page).to have_content "new_name"
      expect(page).to have_content "成功しました"
    end

    example "登録できること" do
      visit new_admin_product_path
      fill_in "product[name]", with: "name"
      fill_in "product[price]", with: 100

      expect {
        click_button "commit"
      }.to change { Product.count }.by(1)

      expect(page).to have_current_path admin_product_path(Product.last)
      expect(page).to have_content "name"
      expect(page).to have_content "成功しました"
    end

    example "削除できること" do
      product
      visit admin_products_path

      expect {
        # jsによるアラートは出ない
        click_link "削除"
      }.to change { Product.count }.by(-1)

      expect(page).to have_current_path admin_products_path
      expect(page).not_to have_content product.name
      expect(page).to have_content "成功しました"
    end
  end
end