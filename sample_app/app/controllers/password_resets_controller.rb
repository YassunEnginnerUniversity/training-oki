class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end

  # 再設定用のフォームからメールアドレスが送信させる時に実行される
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest  # パスワード再設定用のトークンを作成
      @user.send_password_reset_email # メールアドレス送信時のタイムスタンプでreset_sent_atを更新
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new', status: :unprocessable_entity
    end
  end
end
