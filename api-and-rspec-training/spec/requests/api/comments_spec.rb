require 'rails_helper'

RSpec.describe "Api::Comments", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }

  describe "POST /api/posts/{post_id}/comments" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }
      end

      it "他の人の投稿に対して正常にコメントができた場合、ステータスは200で投稿したコメントを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        user_comment = FactoryBot.build(:comment, user: user, post: other_user_post)
        post "/api/posts/#{other_user_post.id}/comments", params: { comment: { content: user_comment.content } }

        expect(user_comment).to be_valid
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("id")
        expect(json_response["content"]).to eq(user_comment.content)
        expect(json_response["post_id"]).to eq(other_user_post.id)
        expect(json_response["user"]["id"]).to eq(user.id)
        expect(json_response["user"]["username"]).to eq(user.username)
        expect(json_response).to have_key("created_at")
      end

      it "コメントのcontentが空のリクエストの場合、422ステータスを返し、エラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/comments", params: { comment: { content: nil } }

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "コメントが空です。")
      end

      it "空のcommentオブジェクトを送信した場合、422ステータスを返し、エラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/comments", params: { comment: {} }

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
      end

      it "不正なキーでリクエストした場合、422ステータスを返し、エラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/comments", params: { invalid_key: { content: "Content" } }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        other_user_post = FactoryBot.create(:post, user: other_user)
        post "/api/posts/#{other_user_post.id}/comments", params: { comment: { content: "テストコメントです" } }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
