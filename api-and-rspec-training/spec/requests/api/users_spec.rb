require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
    end

    it "存在しているユーザの情報を返す" do
      get "/api/users/#{user.id}"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
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

    it "存在しないユーザのIDをリクエストすると404を返す" do
      get "/api/users/#{other_user_id}"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq("error" => "ユーザが見つかりませんでした。")
    end
  end

  context "セッションで認証されていない場合" do
    it "ステータスは401で認証エラーメッセージを返す" do
      get "/api/users/#{user.id}"
  
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
    end
  end
end
