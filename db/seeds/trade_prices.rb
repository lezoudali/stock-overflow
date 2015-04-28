Stock.all.each do |stock|
  stock.last_price = StockQuote::Stock.quote(stock.symbol).last_trade_price_only
  stock.save
end