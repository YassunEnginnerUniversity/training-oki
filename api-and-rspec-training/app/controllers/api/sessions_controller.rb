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
      session[:user_id] = user.id
      render :create
    else
      render json: { error: I18n.t('errors.sessions.invalid_credentials') }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    cookies.delete(:_api_and_rspec_training_session)
    @current_user = nil
    render json: { message: I18n.t('errors.sessions.logout_success') }, status: :ok
  end
end
