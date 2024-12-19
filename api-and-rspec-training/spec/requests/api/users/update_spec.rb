require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, :other_user) }
  let(:json_response) { JSON.parse(response.body) }

  subject { patch "/api/users/#{target_user_id}", params: target_user_data }

  shared_examples "Successful case" do
    it "正しくユーザ情報が更新される" do
      subject
      expect(response).to have_http_status(:ok)

      expect(user.reload.username).to eq("changed_username")
      expect(user.reload.profile).to eq("This is my profile")

      expect(json_response["id"]).to eq(user.id)
      expect(json_response["username"]).to eq("changed_username")
      expect(json_response["profile"]).to eq("This is my profile")
    end
  end

  shared_examples "Successful case save empty profile value" do
    it "profileは空でもDBに保存される" do
      subject
      expect(response).to have_http_status(:ok)
      expect(user.reload.profile).to eq("")

      expect(json_response["id"]).to eq(user.id)
      expect(json_response["username"]).to eq(user.username)
      expect(json_response["profile"]).to eq("")
    end
  end

  shared_examples "Error case" do | status, error_message |
    it "ユーザの更新が失敗する" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["error"]).to eq(error_message)
    end
  end

  context "セッションで認証されており、成功する場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "正しいリクエストの場合" do
      let(:target_user_id) { user.id }
      let(:target_user_data) { { user: { username: "changed_username", profile: "This is my profile" } } }
      include_examples "Successful case"
    end

    context "profileが空の場合" do
      let(:target_user_id) { user.id }
      let(:target_user_data) { { user: { profile: "" } } }
      include_examples "Successful case save empty profile value"
    end
  end

  context "セッションで認証されているが、失敗する場合" do
    before do
      post "/api/login", params: { username: user.username, password: user.password }
    end

    context "profileが200字以上の場合" do
      let(:target_user_id) { user.id }
      let(:target_user_data) { { user: { profile: "a" * 201 } } }
      include_examples "Error case", :unprocessable_content, "ユーザの更新に失敗しました。"
    end

    context "不正なキーの場合" do
      let(:target_user_id) { user.id }
      let(:target_user_data) { { invalid_key: { username: "changed_username", profile: "This is my profile" } } }
      include_examples "Error case", :bad_request, "Bad Request"
    end

    context "空のuserオブジェクトを送信した場合" do
      let(:target_user_id) { user.id }
      let(:target_user_data) { { user: {} } }
      include_examples "Error case", :bad_request, "Bad Request"
    end

    context "自分以外のユーザ情報を編集しようとした場合" do
      let(:target_user_id) { other_user.id }
      let(:target_user_data) { { user: { username: "changed_username", profile: "This is my profile" } } }
      include_examples "Error case", :forbidden, "現在ログインしているユーザーではありません。"
    end
  end

  context "セッションで認証されていない場合" do
    let(:target_user_id) { user.id }
    let(:target_user_data) { { user: { username: "changed_username", profile: "This is my profile" } } }
    include_examples "Error case", :unauthorized, "認証されていないアクセスです。"
  end
end
