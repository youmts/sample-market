require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Product#hide" do
    let(:product) { create(:product) }
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
end
