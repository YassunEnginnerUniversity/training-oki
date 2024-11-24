# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_post) { FactoryBot.build(:post, user: user) }
  let(:invalid_post_over_content) { FactoryBot.build(:post, :post_over_content, user: user) }
  let(:invalid_post) { FactoryBot.build(:post, content: nil, user: user) }

  context "バリデーションの確認" do
    it "contentがある場合は有効である" do
      expect(valid_post).to be_valid
    end

    it "contentがない場合は無効である" do
      expect(invalid_post).not_to be_valid
      expect(invalid_post.errors[:content]).to include("内容を入力してください")
    end

    it "contentが140字以上の場合" do
      expect(invalid_post_over_content).not_to be_valid
      expect(invalid_post_over_content.errors[:content]).to include("140字以上は投稿できません")
    end
  end

  context "関連性の確認" do
    it "ユーザに関連付けられている" do
      expect(valid_post.user).to eq(user)
    end
  end
end
