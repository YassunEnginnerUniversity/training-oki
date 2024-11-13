require 'rails_helper'

RSpec.describe Like, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_post) { FactoryBot.create(:post, user: user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let!(:another_user) { FactoryBot.create(:user, :another_user) }
  let!(:other_user_post) { FactoryBot.create(:post, user: other_user)}
  let!(:another_user_post) { FactoryBot.create(:post, user: other_user)}
  let!(:invalid_post_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { post "/api/posts/#{target_post_id}/like" }

  shared_examples "Successful case" do
    it "他の投稿に対していいねができる" do
      post "/api/posts/#{other_user_post.id}/like"
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq("いいねしました。")
    end

    it "自分の投稿に対していいねができる" do
      post "/api/posts/#{user_post.id}/like"
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq("いいねしました。")
    end

    it "複数の投稿に対していいねができる" do
      post "/api/posts/#{other_user_post.id}/like"
      post "/api/posts/#{another_user_post.id}/like"

      expect(user.likes.count).to eq(2)
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "いいねに失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "正常にいいねができる" do
      include_examples "Successful case"
    end

    context "存在する場合投稿にいいねした場合" do
      let(:target_post_id) { invalid_post_id }
      include_examples "Error case", :not_found, "該当する投稿が見つかりませんでした。"
    end

    context "重複していいねした場合" do
      before do
        post "/api/posts/#{other_user_post.id}/like"
      end
      let(:target_post_id) { other_user_post.id }
      include_examples "Error case", :unprocessable_entity, "すでにいいね済みです。"
    end
  end
  context "セッションで認証されていない場合" do
    let(:target_post_id) { other_user_post.id }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end