class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # セッションにユーザIDを保存

      render json: { message: "ログイン成功" }, status: :ok
    else
      render json: { message: "ログイン失敗" }, status: :unauthorized
    end
  end
end
