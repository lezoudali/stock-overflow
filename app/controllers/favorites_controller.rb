class FavoritesController < ApplicationController


  def update
    current_user.favorite_stocks.destroy_all
    params[:ids].each do |id|
      current_user.favorite_stocks << Stock.find_by_id(id.to_i)
    end
    render :json => []
  end

  def price_history
    prices = []
    params[:ids].each do |id|
      stock = Stock.find_by_id(id.to_i)
      vals = {
        name: "#{stock.symbol}",
        pointInterval: 1.day * 1000,
        pointStart: 1.year.ago.to_i * 1000,
        data: stock.prices_with_weekend
      }
      prices << vals
    end

    render :json => prices
  end

  def quote_data
    data = []
    params[:ids].each do |id|
      stock = Stock.find_by_id(id.to_i)
      data << stock.quote
    end

    render partial: "dashboard/favorites_table"
  end


  def remove
    @favorite = Favorite.find(params[:id])
    @favorite.destroy 
    flash[:info] = "#{@favorite.stock.symbol} was removed from your favorites."
    redirect_to :back
  end
end
