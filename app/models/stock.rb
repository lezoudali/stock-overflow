# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  symbol     :string
#  company    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  last_price :float
#

class Stock < ActiveRecord::Base
  attr_accessor :positive, :negative
  
  include Findable, SentimentAnalysis
  has_many :messages
  has_many :user_stocks
  has_many :tweets
  has_many :users, through: :user_stocks

  def followed_by?(user)
    user.stocks.include?(self)
  end

  def dates(days=365)
    MarketData.chart(self.symbol, days)["Dates"]
  end

  def prices(days=365)
    MarketData.chart(self.symbol, days)["Elements"][0]["DataSeries"]["close"]["values"]
  end

  def quote
    @quote ||= StockQuote::Stock.quote(symbol)
  end

  def prices_with_weekend(days=365)
    new_prices = prices(days).zip(dates(days).map{|d| Date.parse(d)})
    days.times do |i|
      if i < days - 1
        begin
        unless new_prices[i][1] + 1 == new_prices[i+1][1]
          new_prices.insert(i+1 ,[new_prices[i][0], new_prices[i][1] + 1])
        end
        rescue
        end
      end
    end
    new_prices.map(&:first)
  end

  def get_tweets(n = 100)
    $twitter_client.search("$#{symbol}", result_type: "recent", lang: "en").take(n).collect do |tweet|
      found_tweet = Tweet.find_by(url: tweet.url.to_s)
      if found_tweet.nil?
        self.tweets.build(text: tweet.text, url: tweet.url.to_s)
      else
        self.tweets << found_tweet unless self.tweets.include? found_tweet
      end
    end
    save
  end
end

