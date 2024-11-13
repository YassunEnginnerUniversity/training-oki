# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:like) { FactoryBot.build(:like, user: user, post: post) }

  context "バリデーションの確認" do
    it "ユーザとポストが存在する場合は有効である" do
      expect(like).to be_valid
    end

    it "同じユーザが同じポストに複数回いいねできない" do
      like.save
      duplicate_like = FactoryBot.build(:like, user: user, post: post)
      expect(duplicate_like).not_to be_valid
    end
  end

  context "関連性の確認" do
    it "ユーザに関連付けられている" do
      expect(like.user).to eq(user)
    end

    it "ポストに関連付けられている" do
      expect(like.post).to eq(post)
    end
  end
end
