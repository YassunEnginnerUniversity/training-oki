class Api::UsersController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def show
    @user = User.find(params[:id])
    render :show

    # 例外処理（findは、値が取得できなかった場合にActiveRecord::RecordNotFoundを返す）
    rescue ActiveRecord::RecordNotFound
      render json: { error: "ユーザが見つかりませんでした。" }, status: :not_found
  end
end
