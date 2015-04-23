module SentimentAnalysis
  def analyze
    analyzer = SentimentLib::Analyzer.new
    stock_tweets = self.find_tweets(100)
    ratings = stock_tweets.map(&:text).collect{|text| analyzer.analyze(text)}
    scaler(ratings)
  end

  def scaler(array)
    positive = []
    neutral = []
    negative = []
    array.each do |rating|
      if rating >= 1
        positive << rating
      elsif rating == 0 
        neutral << rating
      else rating <= -1
        negative << rating
      end
    end
  end
end