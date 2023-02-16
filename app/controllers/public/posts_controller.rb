class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.save
  end
  
  def index
    @posts = Post.all
  end

  def show
  end
  
  private
  
  def post_params
     params.require(:list).permit(:title, :body)
  end
end
