require 'rails_helper'

RSpec.describe "Api::FollowUsers", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let!(:another_user) { FactoryBot.create(:user, :another_user) }
  let!(:invalid_user_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { post "/api/users/#{target_user_id}/follow" }

  shared_examples "Successful case" do
    it "他のユーザをフォローできる" do
      post "/api/users/#{other_user.id}/follow"
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq("フォローしました。")
    end

    it "複数のユーザをフォローできる" do
      post "/api/users/#{other_user.id}/follow"
      post "/api/users/#{another_user.id}/follow"
      expect(user.followings.count).to eq(2)
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "フォローが失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "正常にフォローできる場合" do
      include_examples "Successful case"
    end

    context "すでにフォローしているユーザーを再フォローする場合" do
      before do
        post "/api/users/#{other_user.id}/follow"
      end
      let(:target_user_id) { other_user.id }
      include_examples "Error case", :unprocessable_entity, "すでにフォローしています。"
    end

    context "存在しないユーザーをフォローする場合" do
      let(:target_user_id) { invalid_user_id }
      include_examples "Error case", :not_found, "該当するユーザーが見つかりませんでした。"
    end

    context "自分自身をフォローする場合" do
      let(:target_user_id) { user.id }
      include_examples "Error case", :unprocessable_entity, "自分自身をフォローすることはできません。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_user_id) { other_user.id }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
