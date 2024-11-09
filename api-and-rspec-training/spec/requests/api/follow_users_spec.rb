require 'rails_helper'

RSpec.describe "Api::FollowUsers", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let!(:another_user) { FactoryBot.create(:user, :another_user) }

  describe "POST /api/users/{id}/follow" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }
      end

      it "ユーザーが他のユーザーをフォローできる" do
        post "/api/users/#{other_user.id}/follow"

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("フォローしました。")
      end

      it "すでにフォローしているユーザーを再フォローすると422のステータスとエラーメッセージを返す" do
        post "/api/users/#{other_user.id}/follow"  # 最初のフォロー
        post "/api/users/#{other_user.id}/follow"  # 2回目のフォロー

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("すでにフォローしています。")
      end

      it "存在しないユーザーをフォローしようとすると404のステータスでエラーメッセージが返される" do
        invalid_user = 9999
        post "/api/users/#{invalid_user}/follow"  # 存在しないユーザーID
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("該当するユーザーが見つかりませんでした。")
      end

      it "自分自身をフォローしようとすると422のステータスとエラーメッセージを返す" do
        post "/api/users/#{user.id}/follow"  # 自分自身のIDでフォロー
      
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("自分自身をフォローすることはできません。")
      end

      it "複数のユーザーをフォローすることができる" do
        post "/api/users/#{other_user.id}/follow"
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("フォローしました。")

        post "/api/users/#{another_user.id}/follow" # 別のユーザーをフォロー
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("フォローしました。")

        expect(user.followings.count).to eq(2)
      end
    end

    context "セッションで認証されていない場合" do
      it "ステータスは401で認証エラーメッセージを返す" do
        post "/api/users/#{other_user.id}/follow"
    
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq("error" => "認証されていないアクセスです。")
      end
    end
  end
end
