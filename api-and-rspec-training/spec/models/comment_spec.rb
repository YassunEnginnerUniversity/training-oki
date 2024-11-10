require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.build(:comment, content: "テストコメント", user: user, post: post) }
  let(:invalid_comment) { FactoryBot.build(:comment, content: nil, user: user, post: post) }

  context "バリデーションの確認" do
    it "contentがある場合は有効である" do
      expect(comment).to be_valid
    end

    it "contentがない場合は無効である" do
      expect(invalid_comment).not_to be_valid
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
