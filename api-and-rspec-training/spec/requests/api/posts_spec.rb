require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }

  describe "GET /api/posts/" do
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

  describe "GET /api/posts/{id}" do
    let!(:user_post) { FactoryBot.create(:post, user: user)}
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
      end

      it "投稿が存在する場合、ステータスは200で投稿の情報を返す" do
        get "/api/posts/#{user_post.id}"
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(user_post.id)
        expect(json_response["content"]).to eq(user_post.content)
      end

      it "存在しない投稿ののIDをリクエストすると404を返す" do
        get "/api/posts/#{other_user_post_id}"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("error" => "該当する投稿が見つかりませんでした。")
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        get "/api/posts/#{user_post.id}"
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
