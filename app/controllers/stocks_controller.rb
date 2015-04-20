class StocksController < ApplicationController

  def index
    @stocks = Stock.all
  end

  def update
    stock = Stock.find_by_id(params[:stock][:id])
    unless stock.users.include?(current_user)
      stock.users << current_user unless stock.users.include?(current_user)
      flash[:success] = "You are now following #{stock.company}"
    end
    redirect_to :back
  end


end
