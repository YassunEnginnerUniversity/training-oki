require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_post) { FactoryBot.build(:post, content: "テスト投稿", user: user) }
  let(:invalid_post) { FactoryBot.build(:post, content: nil, user: user) }

  context "バリデーションの確認" do
    it "contentがある場合は有効である" do
      expect(valid_post).to be_valid
    end

    it "contentがない場合は無効である" do
      expect(invalid_post).not_to be_valid
    end
  end

  context "関連性の確認" do
    it "ユーザに関連付けられている" do
      expect(valid_post.user).to eq(user)
    end
  end
end
