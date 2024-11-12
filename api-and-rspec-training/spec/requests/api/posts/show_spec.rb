require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_post) { FactoryBot.create(:post, user: user) }
  let!(:invalid_user_post_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { get "/api/posts/#{target_post_id}" }

  shared_examples "Successful case" do
    it "該当する投稿を取得できる" do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response["id"]).to eq(user_post.id)
        expect(json_response["content"]).to eq(user_post.content)
        expect(json_response["user"]["id"]).to eq(user_post.user.id)
        expect(json_response["user"]["username"]).to eq(user_post.user.username)
        expect(json_response["likes_count"]).to eq(user_post.likes.count)
        user_post.comments.each_with_index do |comment, index|
          expect(json_response["comments"][index]["id"]).to eq(comment.id)
          expect(json_response["comments"][index]["content"]).to eq(comment.content)
          expect(json_response["comments"][index]["user"]["id"]).to eq(comment.user.id)
          expect(json_response["comments"][index]["user"]["username"]).to eq(comment.user.username)
      end
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "該当する投稿が取得に失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "投稿が存在する場合" do
      let(:target_post_id) { user_post.id }
      include_examples "Successful case"
    end

    context "投稿が存在しない場合" do
      let(:target_post_id) { invalid_user_post_id }
      include_examples "Error case", :not_found, "該当する投稿が見つかりませんでした。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_post_id) { user_post.id }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end