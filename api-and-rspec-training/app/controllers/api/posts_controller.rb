class Api::PostsController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  # 例外処理 JSON以外のリクエストが来たときの場合
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  # 例外処理 パラメータが不正なリクエストの場合（requireで指定してるパラメータ）
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  # 例外処理（findは、値が取得できなかった場合にActiveRecord::RecordNotFoundを返す）
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @posts = Post.all
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def create
    # post_params[:content] が存在しない（空）場合、エラーレスポンスを返す
    if post_params[:content].blank?
      return render json: { error: "投稿内容が空です。" }, status: :unprocessable_entity
    end

    @user_post = current_user.posts.build(post_params)

    if @user_post.save
      render :create
    else
      render json: { error: "投稿できませんでした。" }, status: :unprocessable_entity
    end
  end


  private

    def post_params
      params.require(:post).permit(:content)
    end
end
