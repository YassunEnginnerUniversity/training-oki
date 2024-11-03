require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let!(:user) { FactoryBot.create(:user)}
  let!(:other_user_id) { 9999 }

  context "セッションが保持されている場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }  # 事前にログインをしておく
    end

    it "/api/users/{id}にはアクセスできる" do
      get "/api/users/#{user.id}"
  
      expect(response).to have_http_status(:ok)
    end
  end

  context "セッションが保持されていない場合" do
    it "/api/users/{id}にはアクセスできない" do
      get "/api/users/#{user.id}"
  
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
    end
  end

end
