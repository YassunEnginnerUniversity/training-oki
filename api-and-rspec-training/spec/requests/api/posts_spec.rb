require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
    end

    it "投稿が存在する場合、ステータスは200ですべての投稿を返す" do
      FactoryBot.create_list(:post, 10, user: user)

      get "/api/posts"
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(10)
      json_response.each do | post |
        expect(post["content"]).to be_present # contentが空でないかチェック
      end
    end

    it "投稿が存在しない場合、ステータスは200で空の配列を返す" do
      get "/api/posts"
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(0)
    end
  end

  context "セッションで認証されていない場合" do
    it "ステータスは401で認証エラーメッセージを返す" do
      get "/api/posts"
  
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
    end
  end
end
