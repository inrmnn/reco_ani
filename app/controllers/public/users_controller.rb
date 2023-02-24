class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  
  def show
    # ユーザーページを表示
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def edit
    @user = current_user
  end 
  
  def update
    @user = current_user
    if @user.update(user_params)
       # 更新成功時、マイページへ
       flash[:notice] = "ユーザーの情報を更新しました。"
       redirect_to  user_path(current_user)
    else
      # 更新失敗時
       flash[:notice] = "更新に失敗しました"
       render "edit"
    end
  end 
  
  private
  def user_params
    params.require(:user).permit(:name, :anime_first, :anime_second, :anime_third, :genre_first, :genre_second, :genre_third)
  end
end
