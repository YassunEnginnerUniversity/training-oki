class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in? #ログインしていれば空のmicropostインスタンスを作成している
  end

  def help
  end

  def about
  end

  def contact
  end
end
