class DashboardController < ApplicationController

  def index
    if params[:symbol]
      @stock = Stock.find_by_symbol(params[:symbol].upcase)
    else
      @series = []
      current_user.stocks.first(5).each do |stock|
        vals = {
          name: "#{stock.symbol}",
          pointInterval: 1.day * 1000,
          pointStart: 1.year.ago.to_i * 1000,
          data: stock.prices
        }
        @series << vals
      end
      @series
    end
  end
end
