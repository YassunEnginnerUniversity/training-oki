require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context "バリデーションの確認" do
    it "ユーザ名とパスワードがある場合は有効である" do
      expect(user).to be_valid
    end

    it "ユーザ名がない場合は無効である" do
      user.username = nil
      expect(user).not_to be_valid
    end

    it "パスワードがない場合は無効である" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "ユーザ名が一意であること" do
      FactoryBot.create(:user, username: "unique_user")
      duplicate_user = FactoryBot.build(:user, username: "unique_user")
      expect(duplicate_user).not_to be_valid
    end
  end
end