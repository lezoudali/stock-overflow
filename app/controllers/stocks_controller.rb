class StocksController < ApplicationController
  include StocksHelper

  def index
    @stocks = Stock.all
  end


  def follow
    @stock = Stock.find_by_id(params[:id])
    @stock.users << current_user
    flash[:notice] = "You are now following #{@stock.company}"
    redirect_to :back
  end


  def unfollow
    @stock = Stock.find_by_id(params[:id])
    @stock.users.delete(current_user)
    flash[:alert] = "You stopped following #{@stock.company}"
    redirect_to :back
  end

  def unfavorite
    current_user.favorites.find_by(stock_id: @stock.id).destroy
    redirect_to :back
  end


  def update
    @stock = Stock.find_by_id(params[:id])
    if params[:follow] == "true"
      @stock.users << current_user unless @stock.users.include?(current_user)
      flash[:notice] = "You are now following #{@stock.company}"
    elsif params[:follow] == "false"
      if is_favorite?
        current_user.favorites.find_by(stock_id: @stock.id).destroy
      else
        @stock.users.delete(current_user)
      end
      flash[:alert] = "You stopped following #{@stock.company}"
    end
    redirect_to :back
  end

  def show 
    @stock = Stock.find_by_symbol(params[:symbol].upcase)
  end

  def series_data
    stock = Stock.find_by_symbol(params[:symbol].upcase)
    series = []
    vals = {
      name: stock.symbol,
      pointInterval: 1.day * 1000,
      pointStart: 1.year.ago.to_i * 1000,
      data: stock.prices_with_weekend
    }
    series << vals

    # binding.pry
    render json: series
  end

  def is_favorite?
    current_user.favorites.any? { |fav| fav.stock_id == @stock.id  }
  end
end
