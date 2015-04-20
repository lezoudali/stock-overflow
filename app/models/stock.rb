class Stock < ActiveRecord::Base
  include Findable
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def followed_by?(user)
    user.stocks.include?(self)
  end

end
