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

  def update
    @user = User.find_by(id: params[:id])

    if @user.id != current_user.id
      return render json: { error: "現在ログインしているユーザーではありません。" }, status: :forbidden
    end

    if @user.update(user_params)
      render :update
    else
      render json: { error: "ユーザの更新に失敗しました。" }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :profile)
    end
end
