class Api::PostsController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show
    post = Post.find(params[:id])
    render json: post, status: :ok

    # 例外処理（findは、値が取得できなかった場合にActiveRecord::RecordNotFoundを返す）
    rescue ActiveRecord::RecordNotFound
      render json: { error: "該当する投稿が見つかりませんでした。" }, status: :not_found
  end
end
