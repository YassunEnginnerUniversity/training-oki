class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    # どのユーザに対してfollowをするのか
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format| #どちらかひとつしか実行されない
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed #follower_idに対して、URLのuserIDに該当するuserを取得する
    current_user.unfollow(@user)
    respond_to do |format| #どちらかひとつしか実行されない
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end
end
