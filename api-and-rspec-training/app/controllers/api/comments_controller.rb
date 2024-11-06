class Api::CommentsController < ApplicationController
  def create
    if comment_params[:content].blank?
      return render json: { error: "コメントが空です。" }, status: :unprocessable_entity
    end

    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      render json: comment, status: :ok
    else
      render json: { error: "コメントができませんでした。"}, status: :unprocessable_entity
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
