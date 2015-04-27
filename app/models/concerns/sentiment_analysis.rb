module SentimentAnalysis

  def get_ratings
    analyzer = SentimentLib::Analyzer.new

    tweets.map(&:text).collect do |text| 
      analyzer.analyze(text)
    end
  end

  def scaler
    @positive ||= []
    @negative ||= []

    rating = rating.to_i

    get_ratings.each do |rating|
      if rating == 1
        @positive << rating
      elsif rating > 1
        @positive += [1]*rating
      elsif rating == -1
        @negative << rating
      elsif rating < -1
        @negative += [-1]*(rating*-1)
      end
    end
    
  end

  def percentage
    scaler
    sum = @positive.count + @negative.count
    pos = (@positive.count / sum.to_f) * 100
    neg = (@negative.count / sum.to_f) * 100
    {positive: pos, negative: neg}
  end

end



