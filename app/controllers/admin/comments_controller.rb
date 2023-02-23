class Admin::CommentsController < ApplicationController
    
 def destroy
     @post = Post.find(params[:post_id])
     @comment = @post.comment.find(params[:id])
     @comment.destroy
     redirect_to admin_post_path(@post)
 end
 
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
