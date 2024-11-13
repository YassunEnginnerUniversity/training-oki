# == Schema Information
#
# Table name: follow_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_follow_users_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
require 'rails_helper'

RSpec.describe FollowUser, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :other_user) }
  let(:invalid_follow) { FollowUser.new(follower_id: user.id, followed_id: user.id) }

  context "バリデーションの確認" do
    it "同じユーザーを複数回フォローできない" do
      FollowUser.create(follower_id: user.id, followed_id: other_user.id)
      duplicate_follow = FollowUser.new(follower_id: user.id, followed_id: other_user.id)
      expect(duplicate_follow).not_to be_valid
    end
  end

  context "関連性の確認" do
    it "フォロする側ととフォローされている側が正しく設定されている" do
      follow = FollowUser.create(follower_id: user.id, followed_id: other_user.id)
      expect(follow.follower).to eq(user)
      expect(follow.followed).to eq(other_user)
    end
  end
end
