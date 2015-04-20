module StocksHelper
  def render_button_for(stock)
    @stock = stock
    if stock.followed_by?(current_user)
      render "unfollow_button"
    else
      render "follow_button"
    end
  end
end
