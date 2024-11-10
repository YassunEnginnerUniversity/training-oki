require 'rails_helper'

RSpec.describe "Api::FollowUsers", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let!(:another_user) { FactoryBot.create(:user, :another_user) }
  let(:invalid_user_id) { 9999 }
  let(:json_response){ JSON.parse(response.body) }

  subject { post "/api/users/#{target_user_id}/unfollow" }

  shared_examples "フォロー解除成功" do
    it "フォローを解除できる" do
      subject
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq("フォローを解除しました。")
    end
  end

  shared_examples "フォロー解除失敗" do | status, error_message |
    it "フォローを解除できない" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  describe "POST /api/users/{id}/unfollow" do
    context "セッションで認証されている場合" do
      before do
        post "/api/login", params: { username: user.username, password: user.password }
        unless RSpec.current_example.metadata[:skip_follow]
          post "/api/users/#{other_user.id}/follow"
          post "/api/users/#{another_user.id}/follow"
        end
      end

      context "正常に他のユーザをフォロー解除ができる場合" do
        let(:target_user_id) { other_user.id }
        include_examples "フォロー解除成功"
      end

      context "正常に複数のユーザのフォロー解除ができる場合" do
        let(:target_user_id) { other_user.id }
        include_examples "フォロー解除成功"

        let(:target_user_id) { another_user.id }
        include_examples "フォロー解除成功"
      end

      context "自分自身のフォローを解除する場合" do
        let(:target_user_id) { user.id }
        include_examples "フォロー解除失敗", :unprocessable_entity, "自分自身のフォローを外すことはできません。"
      end

      context "すでにフォローを解除されているユーザを再度フォロー解除する場合", :skip_follow do
        before do
          post "/api/users/#{other_user.id}/follow"
          post "/api/users/#{other_user.id}/unfollow"
        end
        let(:target_user_id) { other_user.id }
        include_examples "フォロー解除失敗", :unprocessable_entity, "すでにフォローを解除しています。"
      end

      context "存在しないユーザにフォロー解除する場合" do
        let(:target_user_id) { invalid_user_id }
        include_examples "フォロー解除失敗", :not_found, "該当するユーザーが見つかりませんでした。"
      end
    end

    context "セッションで認証されていない場合" do
      context "存在するユーザにフォロー解除する場合" do
        let(:target_user_id) { other_user.id }
        include_examples "フォロー解除失敗", :unauthorized, "認証されていないアクセスです。"
      end
    end
  end
end