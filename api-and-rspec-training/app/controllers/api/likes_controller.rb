class Api::LikesController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)


    if @like.save
      render :create
    else
      render json: { error: "すでにいいね済みです。" }, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordNotFound
      render json: { error: "該当する投稿が見つかりませんでした。" }, status: :not_found
  end

  def destroy
      @post = Post.find(params[:post_id])
      like = @post.likes.find_by(user_id: current_user.id)

      if like
        like.delete
        render :delete
      else
        render json: { error: "\u3044\u3044\u306D\u304C\u5B58\u5728\u3057\u307E\u305B\u3093\u3002" }, status: :not_found
      end
  end
end
