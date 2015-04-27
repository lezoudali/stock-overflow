class FavoritesController < ApplicationController
  def update
    current_user.favorite_stocks.destroy_all
    params[:ids].each do |id|
      current_user.favorite_stocks << Stock.find_by_id(id.to_i)
    end
  end
end
