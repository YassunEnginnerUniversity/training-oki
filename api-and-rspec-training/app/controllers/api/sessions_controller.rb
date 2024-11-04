class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # セッションにユーザIDを保存
      render json: { message: "ログインに成功しました。" }, status: :ok
    else
      render json: { error: "無効なユーザネームかパスワードです。" }, status: :unauthorized
    end
  end
end
