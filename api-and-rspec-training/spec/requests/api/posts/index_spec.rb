require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user)}
  let!(:another_user) { FactoryBot.create(:user, :another_user)}
  let!(:follow_user) { FactoryBot.create(:follow_user, follower_id: user.id, followed_id: other_user.id)}
  let!(:follow_user02) { FactoryBot.create(:follow_user, follower_id: user.id, followed_id: another_user.id)}
  let!(:following_ids) { user.followings }
  let!(:following_posts) { Post.where(user_id: following_ids)}
 
  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }
  let(:json_response) { JSON.parse(response.body) }

  subject { get "/api/posts" }

  shared_examples "Successful case" do
    it "10件の投稿を取得することができる" do
      FactoryBot.create_list(:post, 30, user: user)
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response["posts"].length).to eq(10)
      expect(json_response["pagenation"]["current_page"]).to eq(1)
      json_response["posts"].each do |post|
        expect(post["content"]).to be_present
      end
    end

    it "2ページ目の10件の投稿を取得することができる" do
      FactoryBot.create_list(:post, 30, user: user)
      get "/api/posts?per_page=10&page=2"

      expect(response).to have_http_status(:ok)
      expect(json_response["posts"].length).to eq(10)
      expect(json_response["pagenation"]["current_page"]).to eq(2)
      json_response["posts"].each do |post|
        expect(post["content"]).to be_present
      end
    end

    it "投稿が存在しない場合、空の配列を返す" do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response["posts"].length).to eq(0)
    end
  end

  shared_examples "Successful case that only get currentuser's posts" do
    it "すべての自分の投稿だけを取得できる" do
     FactoryBot.create_list(:post, 20, user: user)
      get "/api/posts?user_id=#{user.id}"

      expect(response).to have_http_status(:ok)
      expect(json_response["posts"].length).to eq(10)
      json_response["posts"].each do |post|
        expect(post["content"]).to be_present
      end
    end
  end

  shared_examples "Successfull case that only get currentuser's following posts" do
    it "自分がフォローしている投稿だけを取得できる" do
      FactoryBot.create_list(:post, 10, user: user)
      FactoryBot.create_list(:post, 10, user: other_user)
      FactoryBot.create_list(:post, 10, user: another_user)

      get "/api/posts?user_id=#{user.id}&filter=followings"

      expect(response).to have_http_status(:ok)
      expect(following_posts.length).to eq(20)

      expect(json_response["posts"].length).to eq(10)
      json_response["posts"].each do |post|
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
    it_behaves_like "Successfull case that only get currentuser's following posts"
  end

  context "セッションで認証されていない場合" do
    it_behaves_like "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
