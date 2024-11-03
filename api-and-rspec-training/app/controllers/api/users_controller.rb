class Api::UsersController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認


  def show
    user = User.find(params[:id])

    if user
      render json: user, status: :ok
    else
      render json: { error: "ユーザが見つかりませんでした。" }, status: :not_found
    end
  end
end
