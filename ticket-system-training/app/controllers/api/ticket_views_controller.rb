class Api::TicketViewsController < ApplicationController
    def index 
      @ticket_views = TicketView.all
      render :index
    end
end
