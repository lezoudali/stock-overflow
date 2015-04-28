class StocksController < ApplicationController
  include StocksHelper

  def index
    # @search = Stock.search(params[:q])
    # @stocks = @search.result.paginate(page: params[:page], per_page: 50)
    @stocks = Stock.all
  end

  def update
    stock = Stock.find_by_id(params[:id])
    if params[:follow] == "true"
      stock.users << current_user unless stock.users.include?(current_user)
      flash[:success] = "You are now following #{stock.company}"
    elsif params[:follow] == "false"
      stock.users.delete(current_user)
      flash[:success] = "You stopped following #{stock.company}"
    end
    redirect_to :back
  end

  def show 
    @stock = Stock.find_by_symbol(params[:symbol].upcase)
  end
end
