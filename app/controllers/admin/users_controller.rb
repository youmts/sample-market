class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i(edit update destroy)

  def index
    @users = User.all.order(:email)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: "ユーザの変更に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_url, notice: "ユーザの削除に成功しました"
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :postal_code, :address, :phone_number, :email)
    end
end
