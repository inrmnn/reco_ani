class Admin::CommentsController < ApplicationController
    
 def destroy
    # コメントID、投稿IDを取得
     Comment.find_by(id: params[:id],post_id: params[:post_id]).destroy
      @post = Post.find(params[:post_id])
      # コメント一覧へ戻るへ
     redirect_to admin_comments_path(@post)
     
 end
 
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
