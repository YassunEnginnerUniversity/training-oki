require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe "POST /api/login" do
    context "正しい認証情報を使用した場合" do
      it "ログインが成功し、セッションにユーザーIDが保存される" do
        post "/api/login", params: { username: user.username, password: user.password }

        expect(user).to be_valid
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq("message" => "ログインに成功しました。")
      end
    end

    context "無効なユーザー名を使用した場合" do
      it "ログインに失敗する" do
        post "/api/login", params: { username: "invalid_user", password: "password" }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "無効なユーザネームかパスワードです。")
      end
    end

    context "無効なパスワードを使用した場合" do
      it "ログインが失敗する" do
        post "/api/login", params: { username: user.username, password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "無効なユーザネームかパスワードです。")
      end
    end

    context "usernameが空の場合" do
      it "モデルのバリデーションに引っかかる" do
        invalid_user = FactoryBot.build(:user, username: nil, password: "password")
        post "/api/login", params: { username: invalid_user.username, password: invalid_user.password }
        expect(invalid_user).not_to be_valid
      end
    end

    context "usernameがユニークではない場合" do
      it "モデルのバリデーションに引っかかる" do
        invalid_user = FactoryBot.build(:user, username: "testuser", password: "password")
        post "/api/login", params: { username: invalid_user.username, password: invalid_user.password }
        expect(invalid_user).not_to be_valid
      end
    end

    context "passwordが空の場合" do
      it "モデルのバリデーションに引っかかる" do
        invalid_user = FactoryBot.build(:user, username: "username", password: nil)
        post "/api/login", params: { username: invalid_user.username, password: invalid_user.password }
        expect(invalid_user).not_to be_valid
      end
    end
    
    context "passwordが6文字以下の場合" do
      it "モデルのバリデーションに引っかかる" do
        invalid_user = FactoryBot.build(:user, username: "username", password: "test")
        post "/api/login", params: { username: invalid_user.username, password: invalid_user.password }
        expect(invalid_user).not_to be_valid
      end
    end

    context "不正なリクエストメソッドを使用した場合" do
      it "GETリクエストを送ると404not_foundを返す" do
        get "/api/login", params: { username: user.username, password: user.password }

        expect(response).to have_http_status(:not_found)
      end
      it "PUTリクエストを送ると404not_foundを返す" do
        put "/api/login", params: { username: user.username, password: user.password }

        expect(response).to have_http_status(:not_found)
      end
      it "DELETEリクエストを送ると404not_foundを返す" do
        delete "/api/login", params: { username: user.username, password: user.password }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
