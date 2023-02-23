class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      flash[:notice] = "新しい投稿に成功しました。"
      redirect_to posts_path
    else
      flash[:notice] = "投稿に失敗しました。"
      render "new"
    end 
  end
  
  def index
    
    @posts = Post.where("title LIKE ?", "%#{params[:title]}%")
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
  end 
  
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
     if  @post.update(post_params)
       flash[:notice] = "投稿の更新に成功しました。"
       redirect_to user_path(current_user)
     else
       flash[:notice] = "投稿の更新に失敗しました。"
       render 'edit'
     end
  end
  
  def comment
     @post = Post.find(params[:id])
     @comment = @post.comments.page(params[:page])
  end
  
 def search
     @posts = Post.where("title LIKE ?", "%#{params[:title]}%").page(params[:page])
 end
  
  private
 
  def post_params
     params.require(:post).permit(:title, :body, :genre_id, :comment)
  end
end
