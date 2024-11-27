class Api::UsersController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def me
    @user = current_user
    if @user
      render :me
    else
      render json: { error: "ユーザが見つかりませんでした。" }, status: :not_found
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @current_user = current_user
    if @user
      render :show
    else
      render json: { error: "ユーザが見つかりませんでした。" }, status: :not_found
    end
  end
end
