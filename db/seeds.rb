require "nokogiri"
require "open-uri"


html = File.read(open("http://en.wikipedia.org/wiki/List_of_S%26P_500_companies"))
noko = Nokogiri::HTML(html)
cells = noko.css("h2+table td:first-child a, h2+table td:nth-child(2) a")
cells.each_with_index do |cell, i|
  if (i % 2).zero?
    symbol = cells[i].text 
    if !symbol.include?(".")
      company_name = cells[i+1].text
      stock = Stock.find_or_initialize_by(symbol: symbol)
      stock.company = company_name if stock.new_record?
      stock.last_price = StockQuote::Stock.quote(stock.symbol).last_trade_price_only
      stock.save 
    end
  end
end







