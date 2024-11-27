# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.build(:comment, user: user, post: post) }
  let(:invalid_comment_over_content) { FactoryBot.build(:comment, :comment_over_content, user: user, post: post) }
  let(:invalid_comment) { FactoryBot.build(:comment, content: nil, user: user, post: post) }

  context "バリデーションの確認" do
    it "contentがある場合は有効である" do
      expect(comment).to be_valid
    end

    it "contentがない場合は無効である" do
      expect(invalid_comment).not_to be_valid
      expect(invalid_comment.errors[:content]).to include("内容を入力してください")
    end

    it "contentが140字以上の場合" do
      expect(invalid_comment_over_content).not_to be_valid
      expect(invalid_comment_over_content.errors[:content]).to include("140字以上はコメントできません")
    end
  end

  context "関連性の確認" do
    it "ユーザに関連付けられている" do
      expect(comment.user).to eq(user)
    end

    it "ポストに関連付けられている" do
      expect(comment.post).to eq(post)
    end
  end
end
