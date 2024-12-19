require 'rails_helper'

RSpec.describe "Api::TicketViews", type: :request do
  let!(:organizer) { FactoryBot.create(:organizer) }
  let!(:play_guides) { FactoryBot.create_list(:play_guide, 3) }
  let!(:show) { FactoryBot.create(:show, organizer: organizer) }
  let!(:events) { FactoryBot.create_list(:event, 5, show: show) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:ticket_view) { FactoryBot.create(:ticket_view, user: user, event: events[0]) }
  let!(:ticket_type) { FactoryBot.create(:ticket_type, event: events[0]) }
  let!(:ticket_used) { FactoryBot.create(:ticket, ticket_view: ticket_view, ticket_type: ticket_type, play_guide: play_guides[0], used_time: "2024-01-21 18:00:00") }
  let!(:ticket_not_used) { FactoryBot.create(:ticket, ticket_view: ticket_view, ticket_type: ticket_type, play_guide: play_guides[0]) }

  let(:json_response) { JSON.parse(response.body) }

  # subject: APIリクエストの実行
  subject { get "/api/ticket_views", params: request_params }

  # 成功
  shared_examples "Successful case" do
    it "HTTPステータス200が返る" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "期待したデータが取得できる" do
      subject
      expect(json_response).not_to be_empty
      expect(json_response.first["id"]).to eq(ticket_view.id)
    end
  end

  # エラー
  shared_examples "Error case" do |status, error_message|
    it "指定したステータスとエラーメッセージが返る" do
      subject
      expect(response).to have_http_status(status)
      expect(json_response["message"]).to eq(error_message)
    end
  end

  # 成功ケース：フィルタなし
  context "正常系: フィルタなしで全てのデータを取得" do
    let(:request_params) { {} }
    include_examples "Successful case"
  end

  # 成功ケース：興行IDでフィルタリング
  context "正常系: 興行IDでフィルタリング" do
    let(:request_params) { { show_id: show.id } }
    include_examples "Successful case"
  end

  # 成功ケース: プレイガイドIDでフィルタリング（IDが1つの場合）
  context "正常系: プレイガイドIDでフィルタリング（IDが1つの場合）" do
    let(:request_params) { { play_guide_ids: [play_guides[0].id] } }
    include_examples "Successful case"
  end

  # 成功ケース: プレイガイドIDでフィルタリング（IDが複数の場合）
  context "正常系: プレイガイドIDでフィルタリング（IDが複数の場合）" do
    let(:request_params) { { play_guide_ids: [play_guides[0].id,play_guides[1].id,play_guides[2].id] } }
    include_examples "Successful case"
  end

  # 成功ケース: 公演IDでフィルタリング（IDが1つの場合）
  context "正常系: 公演IDでフィルタリング" do
    let(:request_params) { { event_ids: [events[0].id] } }
    include_examples "Successful case"
  end

  # 成功ケース: 公演IDでフィルタリング（IDが複数の場合）
  context "正常系: 公演IDでフィルタリング" do
    let(:request_params) { { event_ids: [events[0].id, events[1].id, events[2].id] } }
    include_examples "Successful case"
  end

  # 成功ケース: 公演日時でフィルタリング
  context "正常系: 公演日時でフィルタリング" do
    let(:request_params) { { from_date: "2023-12-01", to_date: "2024-01-31" } }
    include_examples "Successful case"
  end

  # 成功ケース: 消し込み済みフラグがtrueの場合
  context "正常系: 消し込み済みフラグがtrueの場合" do
    let(:request_params) { { used: "true" } }
    include_examples "Successful case"
  end
  
  # 成功ケース: 消し込み済みフラグがfalseの場合
  context "正常系: 消し込み済みフラグがfalseの場合" do
    let(:request_params) { { used: "false" } }
    include_examples "Successful case"
  end

  # エラーケース: データが存在しない場合
  context "異常系: データが存在しない場合" do
    let(:request_params) { { show_id: 9999, play_guide_ids:[9999],  event_ids:[9999, from_date: "2025-12-01", to_date: "2025-01-31"] } }
    include_examples "Error case", :not_found, "チケットビューが存在しないです。"
  end
end
