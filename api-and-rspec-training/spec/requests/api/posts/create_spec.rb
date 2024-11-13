require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_post) { FactoryBot.create(:post, user: user)}
  let!(:valid_post) {FactoryBot.build(:post, user: user)}
  let!(:invalid_user_post_id) { 9999 }
  let(:json_response) { JSON.parse(response.body)}

  subject { post "/api/posts", params: target_post_data } 

  shared_examples "Successful case" do
    it "投稿ができる" do
      subject
      expect(response).to have_http_status(:ok)
      expect(valid_post).to be_valid
      expect(response).to have_http_status(:ok)

      expect(json_response).to have_key("id")
      expect(json_response["content"]).to eq(valid_post.content)
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "投稿が失敗する" do
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
      let(:target_post_data) { { post:{ content: valid_post.content }} }
      include_examples "Successful case"
    end

    context "contentが空のリクエストの場合" do
      let(:target_post_data) { { post:{ content: nil } }}
      include_examples "Error case", :unprocessable_entity, "投稿内容が空です。"
    end

    context "空のpostオブジェクトを送信した場合" do
      let(:target_post_data) { {} }
      include_examples "Error case", :unprocessable_entity, "不正なリクエストであるため、保存できませんでした。"
    end
    context "不正なキーでリクエストした場合" do
      let(:target_post_data) { { invalid_key: { content: "Content" } } }
      include_examples "Error case", :unprocessable_entity, "不正なリクエストであるため、保存できませんでした。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_post_data) { { post:{ content: valid_post.content }} }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end