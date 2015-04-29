class FavoritesController < ApplicationController
  def update
    current_user.favorite_stocks.destroy_all
    params[:ids].each do |id|
      current_user.favorite_stocks << Stock.find_by_id(id.to_i)
    end
  end

  def price_history
    prices = []
    params[:ids].each do |id|
      stock = Stock.find_by_id(id.to_i)
      prices << stock.prices
    end

    render :json => prices
  end

  def quote_data
    data = []
    params[:ids].each do |id|
      stock = Stock.find_by_id(id.to_i)
      data << stock.quote
    end

    render :json => data
  end
end
