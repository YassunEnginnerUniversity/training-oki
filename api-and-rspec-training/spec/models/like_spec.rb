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
