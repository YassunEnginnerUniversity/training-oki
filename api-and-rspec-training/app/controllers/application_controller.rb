class ApplicationController < ActionController::API
  private

  # 認証メソッド（失敗や例外を伴う可能性があるため!をつけている）
  def authenticate_user!
    unless session[:user_id]
      render json: { error: "認証されていないアクセスです。"}, status: :unauthorized
    end
  end

  def current_user
    if (user_id = session[:user_id]) # 代入と評価を同時にやっている
      user = User.find_by(id: user_id)
      @current_user ||= User.find_by(id: user_id) # find_byを実行するまでに、すでに@current_userに値がないが確認し、値があればそれを返す。
    end
  end
end
