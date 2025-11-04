class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "コメントを投稿しました。"
    else
      redirect_to @post, alert: "コメントを入力してください。"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @comment.post, notice: "コメントを削除しました。"
    else
      redirect_to @comment.post, alert: "削除権限がありません。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
