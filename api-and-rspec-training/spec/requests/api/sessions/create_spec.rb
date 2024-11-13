require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:invalid_username_user) { { username: "invalid_user", password: "password" } }
  let!(:invalid_password_user) { { username: user.username, password: "wrong_password" } }
  let(:json_response) { JSON.parse(response.body) }

  subject { post "/api/login", params: target_user_data }

  shared_examples "Successful case" do
    it "ログインできる" do
      subject
      expect(user).to be_valid
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq("ログインに成功しました。")
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "ログインできない" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  shared_examples "Error case invaild http request method" do | status, error_message |
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

  context "正常にログインできる" do
    let(:target_user_data) { { username: user.username, password: user.password } }
    include_examples "Successful case"
  end

  context "無効なユーザー名を使用した場合" do
    let(:target_user_data) { invalid_username_user }
    include_examples "Error case", :unauthorized, "無効なユーザネームかパスワードです。"
  end

  context "無効なパスワードを使用した場合" do
    let(:target_user_data) { invalid_password_user }
    include_examples "Error case", :unauthorized, "無効なユーザネームかパスワードです。"
  end

  context "不正なリクエストメソッドを使用した場合" do
    include_examples "Error case invaild http request method"
  end
end
