class ApplicationController < ActionController::API
  private

  # 認証メソッド（失敗や例外を伴う可能性があるため!をつけている）
  def authenticate_user!
    unless session[:user_id]
      render json: { error: "認証されていないアクセスです。" }, status: :unauthorized
    end
  end

  def current_user
    if (user_id = session[:user_id]) # 代入と評価を同時にやっている
      user = User.find_by(id: user_id)
      @current_user ||= User.find_by(id: user_id) # find_byを実行するまでに、すでに@current_userに値がないが確認し、値があればそれを返す。
    end
  end

  def handle_parse_error(exception)
    render json: { error: "リクエストはJSON形式である必要があります。" }, status: :bad_request
  end

  def handle_parameter_missing(exception)
    render json: { error: "不正なリクエストであるため、保存できませんでした。" }, status: :unprocessable_entity
  end

  def handle_record_not_found(exception)
    error_message = case exception.model
    when "Post"
      "該当する投稿が見つかりませんでした。"
    when "Comment"
      "該当するコメントが見つかりませんでした。"
    else
      "該当するレコードが見つかりませんでした。"
    end
    render json: { error: error_message }, status: :not_found
  end
end
