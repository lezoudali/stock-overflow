class DashboardController < ApplicationController

  def index
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
