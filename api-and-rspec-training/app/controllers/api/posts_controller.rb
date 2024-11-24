class Api::PostsController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  # 例外処理 JSON以外のリクエストが来たときの場合
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  # 例外処理 パラメータが不正なリクエストの場合（requireで指定してるパラメータ）
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  # 例外処理（findは、値が取得できなかった場合にActiveRecord::RecordNotFoundを返す）
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @current_user = current_user
    @user_id = params[:user_id].to_i
    @filterName = params[:filter]

    page = params[:page] || 0  # 現在のページ
    per_page = params[:per_page] || 10 # 表示件数


    if @filterName == "followings" && @user_id == @current_user.id
      following_ids = @current_user.followings
      @current_user_following_posts = Post.where(user_id: following_ids).order(created_at: :desc).page(page).per(per_page)
    elsif @user_id == @current_user.id
      @current_user_posts = current_user.posts.order(created_at: :desc).page(page).per(per_page)
    else
      @posts = Post.order(created_at: :desc).page(page).per(per_page)
    end
    
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
      if @user_post.errors[:content].include?("140字以上は投稿できません")
        render json: { error: "140字以上は投稿できません" }, status: :unprocessable_entity
      elsif @user_post.errors[:content].include?("内容を入力してください")
        render json: { error: "内容を入力してください" }, status: :unprocessable_entity
      end
    end
  end


  private

    def post_params
      params.require(:post).permit(:content)
    end
end
