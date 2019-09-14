class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i(add remove)
  before_action :set_product, only: %i(show add_cart remove_cart)

  def index
    @products = Product.all
  end

  def show
  end

  def add_cart
    current_user.add_cart!(@product)

    redirect_back fallback_location: root_path, notice: "カートに追加しました"
  end

  def remove_cart
    current_user.remove_cart!(@product)

    redirect_back fallback_location: root_path, notice: "カートから削除しました"
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
end
