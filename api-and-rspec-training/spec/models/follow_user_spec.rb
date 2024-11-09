require 'rails_helper'

RSpec.describe FollowUser, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :other_user) }
  let(:invalid_follow) {FollowUser.new(follower_id: user.id, followed_id: user.id) }

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
