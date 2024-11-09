require 'rails_helper'

RSpec.describe "Api::Likes", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user) { FactoryBot.create(:user, :other_user) }

  describe "POST /api/posts/{post_id}/like" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
      end

      it "他の人の投稿に対していいねができる" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/like"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("いいねしました。")
      end

      it "自分の投稿に対していいねができる" do
        user_post = FactoryBot.create(:post, user: user)
        post "/api/posts/#{user_post.id}/like"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("いいねしました。")
      end

      it "重複していいねした場合、ステータスは422でエラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/like"  # 最初の「いいね」
        post "/api/posts/#{other_user_post.id}/like"  # 2回目の「いいね」
    
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("すでにいいね済みです。")
      end

      it "存在しない投稿の場合、ステータスは404でエラーメッセージを返す" do
        invalid_post_id = 9999
        post "/api/posts/#{invalid_post_id}/like"

        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("該当する投稿が見つかりませんでした。")
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/like"
    
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
