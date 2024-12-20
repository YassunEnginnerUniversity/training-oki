class Api::TicketViewsController < ApplicationController
    def index 
      # パラメータの取得
      play_guide_ids = params[:play_guide_ids] || [] #プレイガイドID（複数可）
      show_id = params[:show_id] #興行ID
      event_ids = params[:event_ids] || [] #公演ID（複数可）
      from_date = params[:from_date] #公演の日時
      to_date = params[:to_date] #公演の日時
      used_flag = params[:used] #消し込み

      # eventテーブルとshowテーブルをINNER JOINさせ、N+1を対策ため、includesで最小限のクエリにする
      @ticket_views = TicketView.joins(tickets: :play_guide, event: :show).includes(tickets: { play_guide: {} }, event: { show: {} })

      # 興行IDでフィルタリング
      @ticket_views = @ticket_views.where(shows: { id: show_id }) if show_id.present?

      # プレイガイドID（複数）でフィルタリング
      @ticket_views = @ticket_views.where(tickets: { play_guide_id: play_guide_ids }) if play_guide_ids.present?

      # 公演ID（複数）でフィルタリング
      @ticket_views = @ticket_views.where(events: { id: event_ids }) if event_ids.present?

      # 公演日時でフィルタリング
      if from_date.present? && to_date.present?
        @ticket_views = @ticket_views.where(events: { date: from_date..to_date })
      end

      # 消し込み済みフラグでフィルタリング
      if used_flag.present?
        @ticket_views = @ticket_views.where.not(tickets: {used_time: nil}) if used_flag == "true"
        @ticket_views = @ticket_views.where(tickets: {used_time: nil}) if used_flag == "false"
      end

       # データ存在確認
      if @ticket_views.exists?
        render :index
      else
        render json: { message: "チケットビューが存在しないです。" }, status: :not_found
      end
      end
end
