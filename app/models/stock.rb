# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  symbol     :string
#  company    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Stock < ActiveRecord::Base
  include Findable
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def followed_by?(user)
    user.stocks.include?(self)
  end

  def prices(days=365)
    MarketData.chart(self.symbol, days)["Elements"][0]["DataSeries"]["close"]["values"]
  end

  def dates(days=365)
    MarketData.chart(self.symbol, days)["Dates"]
  end
end
