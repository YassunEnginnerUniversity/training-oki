require 'rails_helper'

RSpec.describe "Api::Comments", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let!(:other_user_post) { FactoryBot.create(:post, user: other_user) }
  let!(:user_comment) { FactoryBot.build(:comment, user: user, post: other_user_post) }
  let(:json_response) { JSON.parse(response.body) }

  subject { post "/api/posts/#{other_user_post.id}/comments", params: target_comment_data }

  shared_examples "Successful case" do
    it "コメントができる" do
      subject
      expect(user_comment).to be_valid
      expect(response).to have_http_status(:ok)

      expect(json_response).to have_key("id")
      expect(json_response["content"]).to eq(user_comment.content)
      expect(json_response["post_id"]).to eq(other_user_post.id)
      expect(json_response["user"]["id"]).to eq(user.id)
      expect(json_response["user"]["username"]).to eq(user.username)
      expect(json_response).to have_key("created_at")
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "コメントが失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "正しいリクエストの場合" do
      let(:target_comment_data) { { comment: { content: user_comment.content } } }
      include_examples "Successful case"
    end

    context "contentが空のリクエストの場合" do
      let(:target_comment_data) { { comment: { content: nil } } }
      include_examples "Error case", :unprocessable_entity, "コメントが空です。"
    end

    context "空のcommentオブジェクトを送信した場合" do
      let(:target_comment_data) { {} }
      include_examples "Error case", :unprocessable_entity, "不正なリクエストであるため、保存できませんでした。"
    end

    context "不正なキーでリクエストした場合" do
      let(:target_comment_data) { { invalid_key: { content: "Content" } } }
      include_examples "Error case", :unprocessable_entity, "不正なリクエストであるため、保存できませんでした。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_comment_data) { { comment: { content: user_comment.content } } }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
