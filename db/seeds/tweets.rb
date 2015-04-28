MAX_ATTEMPTS = 3
num_attempts = 0
Stock.all.each_with_index do |stock, i|
  begin
    num_attempts += 1
    stock.get_tweets
  rescue Twitter::Error::TooManyRequests => error
    if num_attempts <= MAX_ATTEMPTS
      sleep error.rate_limit.reset_in
      retry 
    end
  end
end

