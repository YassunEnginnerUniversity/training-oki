class Api::SessionsController < ApplicationController
  def check
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      render json: { login_in: true, id: @user.id, username: @user.username }, status: :ok
    else
      render json: { login_in: false}, status: :unauthorized
    end
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # セッションにユーザIDを保存
      render :create
    else
      render json: { error: "無効なユーザネームかパスワードです。" }, status: :unauthorized
    end
  end
end
