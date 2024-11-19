require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user)}

  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { get "/api/posts" }

  shared_examples "Successful case" do
    it "すべての投稿を取得できる" do
      FactoryBot.create_list(:post, 10, user: user)
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(10)
      json_response.each do |post|
        expect(post["content"]).to be_present
      end
    end

    it "投稿が存在しない場合、空の配列を返す" do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(0)
    end
  end

  shared_examples "Successful case that only get currentuser's posts" do
    it "すべての自分の投稿だけを取得できる" do
      FactoryBot.create_list(:post, 10, user: user)
      FactoryBot.create_list(:post, 10, user: other_user)

      get "/api/posts?user_id=#{user.id}"

      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(10)
      json_response.each do |post|
        expect(post["content"]).to be_present
      end
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "すべての投稿が取得に失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end
    it_behaves_like "Successful case"

    it_behaves_like "Successful case that only get currentuser's posts"
  end

  context "セッションで認証されていない場合" do
    it_behaves_like "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
