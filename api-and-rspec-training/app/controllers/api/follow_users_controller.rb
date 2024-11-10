class Api::FollowUsersController < ApplicationController
  before_action :authenticate_user! # セッションを保持しているかアクションの前に確認

  def create
    followed_user = User.find(params[:user_id])

    if current_user == followed_user
      render json: { error: "自分自身をフォローすることはできません。" }, status: :unprocessable_entity
    elsif current_user.followings.include?(followed_user)
      render json: { error: "すでにフォローしています。" }, status: :unprocessable_entity
    else
      current_user.followings << followed_user # ログインしているユーザのfollowしているユーザの配列にフォローしたユーザを追加し、DBに保存する
      render :create
    end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "該当するユーザーが見つかりませんでした。" }, status: :not_found
  end
end
