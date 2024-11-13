require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:invaild_user_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { get "/api/users/#{target_user_id}" }

  shared_examples "Successful case" do
    it "該当するユーザが取得できる" do
      subject
      expect(json_response["id"]).to eq(user.id)
      expect(json_response["username"]).to eq(user.username)
      user.posts.each_with_index do |post, index|
        expect(json_response["posts"][index]["id"]).to eq(post.id)
        expect(json_response["posts"][index]["content"]).to eq(post.content)
        expect(json_response["posts"][index]["likes_count"]).to eq(post.likes.count)
      end
      user.likes.each_with_index do |like, index|
        expect(json_response["likes"][index]["post_id"]).to eq(like.post_id)
      end
      expect(json_response["followers_count"]).to eq(user.followers.count)
      expect(json_response["following_count"]).to eq(user.followings.count)
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "ユーザが取得できない" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "正常に該当のユーザを返す" do
      let(:target_user_id) { user.id }
      include_examples "Successful case"
    end

    context "存在しないユーザのIDをリクエストする場合" do
      let(:target_user_id) { invaild_user_id }
      include_examples "Error case", :not_found, "ユーザが見つかりませんでした。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_user_id) { user.id }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
