class Api::LikesController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def create
    post = Post.find(params[:id])
    like = post.likes.build(user:current_user)

    if like.save
      render json: { message: "いいねしました。"}, status: :ok
    else
      render json: { error: "すでにいいね済みです。"}, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordNotFound
      render json: { error: "該当する投稿が見つかりませんでした。" }, status: :not_found
  end
end
