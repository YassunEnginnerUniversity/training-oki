class Api::PostsController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  # 例外処理 JSON以外のリクエストが来たときの場合
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  # 例外処理 パラメータが不正なリクエストの場合
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  # 例外処理（findは、値が取得できなかった場合にActiveRecord::RecordNotFoundを返す）
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show
    post = Post.find(params[:id])
    render json: post, status: :ok
  end

  def create
    # post_params[:content] が存在しない（空）場合、エラーレスポンスを返す
    if post_params[:content].blank?
      return render json: { error: "投稿内容が空です。" }, status: :unprocessable_entity
    end

    user_post = current_user.posts.build(post_params)

    if user_post.save
      render json: user_post, status: :ok
    else
      render json: { error: "投稿できませんでした。" }, status: :unprocessable_entity
    end
  end


  private

    def post_params
      params.require(:post).permit(:content)
    end

    def handle_parse_error(exception)
      render json: { error: "リクエストはJSON形式である必要があります。" }, status: :bad_request
    end

    def handle_parameter_missing(exception)
      render json: { error: "不正なリクエストであるため、投稿できませんでした。" }, status: :unprocessable_entity
    end

    def handle_record_not_found(exception)
      render json: { error: "該当する投稿が見つかりませんでした。" }, status: :not_found
    end
end
