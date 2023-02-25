class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    # ログインユーザーを取得
    @post.user_id = current_user.id
    if  @post.save
      # 投稿成功時、投稿一覧画面へ
      flash[:notice] = "新しい投稿に成功しました。"
      redirect_to posts_path
    else
      # 投稿失敗時
      flash[:alert] = "投稿に失敗しました。"
      render "new"
    end 
  end
  
  def index
    # 検索機能（文字列のどの部分にでも文字が含まれていたら表示）
    @posts = Post.where("title LIKE ?", "%#{params[:title]}%")
    @user = current_user
    @genres = Genre.all
    # ジャンルごとの一覧画面を表示
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
    # コメント機能
    @comment = Comment.new
    
  end
  
  def destroy
    @post = Post.find(params[:id])
     # 投稿削除
    @post.destroy
    # マイページに遷移
    redirect_to user_path(current_user)
  end 
  
  def edit
    @post = Post.find(params[:id])
  end 
  
  def update
    @post = Post.find(params[:id])
     # ログインユーザーを取得
    @post.user_id = current_user.id
     if  @post.update(post_params)
      # 更新成功時、マイページへ
       flash[:notice] = "投稿の更新に成功しました。"
       redirect_to user_path(current_user)
     else
      # 更新失敗時
       flash[:alert] = "投稿の更新に失敗しました。"
       render 'edit'
     end
  end
  
  def comment
     @post = Post.find(params[:id])
     @user = @post.user
    # 投稿に紐づいたコメントを表示
     @comment = @post.comments.page(params[:page])
  end
  
 def search
  # 検索結果を表示
     @posts = Post.where("title LIKE ?", "%#{params[:title]}%").page(params[:page])
 end
  
  private
 
  def post_params
     params.require(:post).permit(:title, :body, :genre_id, :comment)
  end
end
