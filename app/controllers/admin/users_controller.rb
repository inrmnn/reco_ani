class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # 管理者ユーザー一覧画面へ
    redirect_to admin_users_path
  end
end
