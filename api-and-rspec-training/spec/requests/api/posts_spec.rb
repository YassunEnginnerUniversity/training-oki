require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }

  describe "POST /api/posts/" do
    let!(:user_post) { FactoryBot.create(:post, user: user) }
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }
      end

      it "正しいリクエストの場合、200ステータスと保存した投稿情報を返す" do
        valid_post = FactoryBot.build(:post, content: "正しいリクエスト投稿です", user: user)
        post "/api/posts", params: { post: { content: valid_post.content } }

        expect(valid_post).to be_valid
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("id")
        expect(json_response["content"]).to eq(valid_post.content)
      end

      it "contentが空のリクエストの場合、422ステータスを返し、エラーメッセージを返す" do
        post "/api/posts", params: { post: { content: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq("error" => "投稿内容が空です。")
      end

      it "空のpostオブジェクトを送信した場合、422ステータスを返し、エラーメッセージを返す" do
        post "/api/posts", params: { post: {} }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
      end

      it "不正なキーでリクエストした場合、422ステータスを返し、エラーメッセージを返す" do
        post "/api/posts", params: { invalid_key: { content: "Content" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        post "/api/posts", params: { content: user_post.content }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
