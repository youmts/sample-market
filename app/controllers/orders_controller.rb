class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(create_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[id])
  end

  def new
    @order = current_user.orders.build
    @order.delivery = current_user.delivery
    @order.build_items(current_user)
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.build_items(current_user)

    if @order.save
      @order.update_user_delivery!

      redirect_to root_path, notice: "ご注文ありがとうございます。"
    else
      render :new
    end
  end

  private
    def order_params
      params.require(:order).permit(:name, :postal_code, :address, :phone_number, :delivery_date, :delivery_time, :save_delivery)
    end
end
