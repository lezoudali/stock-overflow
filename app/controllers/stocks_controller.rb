class StocksController < ApplicationController
  include StocksHelper

  def index
    @stocks = Stock.all
  end

  def update
    @stock = Stock.find_by_id(params[:id])
    if params[:follow] == "true"
      @stock.users << current_user unless @stock.users.include?(current_user)
      flash[:success] = "You are now following #{@stock.company}"
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

  def is_favorite?
    current_user.favorites.any? { |fav| fav.stock_id == @stock.id  }
  end
end
