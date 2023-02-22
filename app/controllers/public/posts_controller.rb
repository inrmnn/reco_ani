class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new
    @genres = Genre.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save!
    redirect_to posts_path
  end
  
  def index
    @posts = Post.page(params[:page])
    @user = current_user
    @genres = Genre.all
       if params[:genre_id]
         @genre = Genre.find(params[:genre_id])
         @posts = @genre.posts.page(params[:page])
       else
         @posts = Post.page(params[:page])
       end 
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end 
  
  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end 
  
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    redirect_to user_path(current_user)
  end
  
  def comment
     @post = Post.find(params[:id])
     @comment = @post.comments.page(params[:page])
  end
  private
  
  def post_params
     params.require(:post).permit(:title, :body, :genre_id, :comm)
  end
end
