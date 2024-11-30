# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  profile         :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
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

    it "profileは200字以上は無効である" do
      user.profile = "a" * 201
      expect(user).not_to be_valid
    end
  end
end
