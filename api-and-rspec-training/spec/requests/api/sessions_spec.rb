require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe "POST /api/login" do
    context "正しい認証情報を使用した場合" do
      it "ログインが成功し、セッションにユーザーIDが保存される" do
        post "/api/login", params: { username: user.username, password: user.password }

        expect(response).to have_http_status(:ok)

        expect(JSON.parse(response.body)).to eq("message" => "ログイン成功")
      end
    end
  end
end
