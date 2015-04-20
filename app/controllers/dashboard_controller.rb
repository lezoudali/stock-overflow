class DashboardController < ApplicationController

  def index
    @stock = Stock.find_by_symbol(params[:symbol].upcase)
  end
end
