module SentimentAnalysis
  @@positive = []
  @@negative = []

  def analyze
    analyzer = SentimentLib::Analyzer.new
    stock_tweets = self.find_tweets(100)
    ratings = stock_tweets.map(&:text).collect{|text| analyzer.analyze(text)}
    scaler(ratings)
  end

  def scaler(array)
    array.each do |rating|
      if rating >= 1
        @@positive << rating
      else rating <= -1
        @@negative << rating
      end
    end
    # binding.pry
  end

  def sum 
    self.analyze
   @@positive.count + @@negative.count
   # binding.pry
  end

  def positive_percentage
    @@positive.count / sum * 100
  end

  def negative_percentage
    @@negative.count / sum * 100
  end
end