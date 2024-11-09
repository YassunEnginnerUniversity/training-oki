require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context "バリデーションの確認" do
    it "usernameが空の場合は無効である" do
      user.username = nil
      expect(user).not_to be_valid
    end

    it "usernameがユニークである必要がある" do
      FactoryBot.create(:user, username: "testuser")
      duplicate_user = FactoryBot.build(:user, username: "testuser")
      expect(duplicate_user).not_to be_valid
    end

    it "passwordが空の場合は無効である" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "passwordが6文字以下の場合は無効である" do
      user.password = "short"
      expect(user).not_to be_valid
    end
  end
end
