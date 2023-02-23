class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def edit
    @user = current_user
  end 
  
  def update
    @user = current_user
    if @user.update(user_params)
       flash[:notice] = "ユーザーの情報を更新しました。"
       redirect_to  user_path(current_user)
    else
       flash[:notice] = "更新に失敗しました"
       render "edit"
    end
  end 
  
  private
  def user_params
    params.require(:user).permit(:name, :anime_first, :anime_second, :anime_third, :genre_first, :genre_second, :genre_third)
  end
end
