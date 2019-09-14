class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def add
    current_user.add_cart!(params[:product_id])

    respond_to do |format|
      format.js
      format.html { redirect_to cart_index_path }
    end
  end

  def remove
    current_user.remove_cart!(params[:product_id])

    redirect_to cart_index_path
  end
end
