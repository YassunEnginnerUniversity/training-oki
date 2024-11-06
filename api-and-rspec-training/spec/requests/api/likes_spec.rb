require 'rails_helper'

RSpec.describe "Api::Likes", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }

  describe "POST /api/posts/{post_id}/like" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
      end

      it "投稿に対していいねができる" do
        user_post = FactoryBot.create(:post, user: user)
        post "/api/posts/#{user_post.id}/like"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("いいねしました。")
      end

      it "重複していいねした場合、ステータスは422でエラーメッセージを返す" do
        user_post = FactoryBot.create(:post, user: user)
        post "/api/posts/#{user_post.id}/like"  # 最初の「いいね」
        post "/api/posts/#{user_post.id}/like"  # 2回目の「いいね」
    
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("すでにいいね済みです。")
      end
    end

    context "セッションで認証されていない場合" do
      let!(:user_post) { FactoryBot.create(:post, user: user)}
      it "ステータスは401で認証エラーメッセージを返す" do
        post "/api/posts/#{user_post.id}/like"
    
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
