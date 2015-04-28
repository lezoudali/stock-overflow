class SearchController < ApplicationController

  def query
    q = params[:query]
    @companies = Stock.where("company like ? or symbol like ?", "#{q}%", "#{q}%")
    render :json => @companies
  end

end
