class DashboardController < ApplicationController

  def index
    @series = []
    current_user.favorite_stocks.each do |stock|
      vals = {
        name: "#{stock.symbol}",
        pointInterval: 1.day * 1000,
        pointStart: 1.year.ago.to_i * 1000,
        data: stock.prices_with_weekend
      }
      @series << vals
    end
    @series
  end
end
