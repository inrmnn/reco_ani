class Admin::PostsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
     @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # 投稿一覧画面へ遷移
    redirect_to admin_root_path
  end 
  
  
  
  def comments
     @post = Post.find(params[:id])
     @comments = @post.comments.page(params[:page])
  end
end
