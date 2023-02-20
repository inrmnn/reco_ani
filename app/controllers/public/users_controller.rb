class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
   
  end
  
  def edit
    @user = current_user
  end 
  
  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(current_user)
  end 
  
  private
  def user_params
    params.require(:user).permit(:name, :anime_first, :anime_second, :anime_third, :genre_first, :genre_second, :genre_third)
  end
end
