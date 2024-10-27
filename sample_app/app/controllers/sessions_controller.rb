class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        reset_session      # ログインの直前に必ずこれを書くこと
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        redirect_to user_url(user)
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destory
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
