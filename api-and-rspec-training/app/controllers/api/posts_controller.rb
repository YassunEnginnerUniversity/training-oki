class Api::PostsController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show

  end
end
