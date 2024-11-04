class ApplicationController < ActionController::API
  private

  # 認証メソッド（失敗や例外を伴う可能性があるため!をつけている）
  def authenticate_user!
    unless session[:user_id]
      render json: { error: "認証されていないアクセスです。"}, status: :unauthorized
    end
  end
end
