class Public::CommentsController < ApplicationController
    def create
      post = Post.find(params[:post_id])
      comment = current_user.comments.new(comment_params)
      comment.post_id = post.id
      if comment.save
        # コメント成功時、コメント一覧へ
        flash[:notice] = "コメントを投稿しました。"
        redirect_to comment_path(post)
      else
        # コメント失敗時、投稿詳細へ
        flash[:alert] = "投稿の投稿に失敗しました。"
        redirect_to post_path(post)
      end
    end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
