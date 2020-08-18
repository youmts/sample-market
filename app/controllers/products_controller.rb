class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i(add_cart remove_cart)
  before_action :set_product, only: %i(show add_cart remove_cart)

  def index
    @products = Product.where(hid_at: nil).order(row_order: :asc)
  end

  def show
  end

  def add_cart
    num = current_user.add_cart!(@product)

    redirect_back fallback_location: root_path, notice: "カートに追加しました（現在#{num}個）"
  end

  def remove_cart
    num = current_user.remove_cart!(@product)

    redirect_back fallback_location: root_path, notice: "カートから削除しました（現在#{num}個）"
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
end
