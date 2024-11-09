require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }
  let!(:other_user_post_id) { 9999 }

  describe "GET /api/posts/" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
      end
      
      it "投稿が存在する場合、ステータスは200ですべての投稿を返す" do
        FactoryBot.create_list(:post, 10, user: user)

        get "/api/posts"
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(10)
        json_response.each do | post |
          expect(post["content"]).to be_present # contentが空でないかチェック
        end
      end

      it "投稿が存在しない場合、ステータスは200で空の配列を返す" do
        get "/api/posts"
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(0)
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        get "/api/posts"
    
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end

  describe "GET /api/posts/{id}" do
    let!(:user_post) { FactoryBot.create(:post, user: user)}
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
      end

      it "投稿が存在する場合、ステータスは200で投稿の情報を返す" do
        get "/api/posts/#{user_post.id}"
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
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

      it "存在しない投稿ののIDをリクエストすると404を返す" do
        get "/api/posts/#{other_user_post_id}"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("error" => "該当する投稿が見つかりませんでした。")
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        get "/api/posts/#{user_post.id}"
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end

  describe "POST /api/posts/" do
    let!(:user_post) { FactoryBot.create(:post, user: user)}
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
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
        invalid_post = FactoryBot.build(:post, content: nil, user: user)
        post "/api/posts", params: { post: { content: invalid_post.content } }

        expect(invalid_post).not_to be_valid
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "投稿内容が空です。")
      end

      it "空のpostオブジェクトを送信した場合、422ステータスを返し、エラーメッセージを返す" do
        post "/api/posts", params: { post: {} }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
      end

      it "不正なキーでリクエストした場合、422ステータスを返し、エラーメッセージを返す" do
        post "/api/posts", params: { invalid_key: { content: "Content" } }
  
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq("error" => "不正なリクエストであるため、保存できませんでした。")
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
