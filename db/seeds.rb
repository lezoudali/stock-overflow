# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'yaml'

# items = YAML::load File.new('db/item.yml').read
# items.each do |item_data|
#   item_hash = item_data.second
#   item = Item.new(item_hash)
#   price_delta = item.original_price.to_f * 0.2
#   min_price = item.original_price.to_f - price_delta
#   max_price = item.original_price.to_f + price_delta
#   30.times do 
#     item.listings.build(price: rand(min_price..max_price).round(2))
#   end
#   item.save!
# end

require "nokogiri"
require "open-uri"

html = File.read(open("http://en.wikipedia.org/wiki/List_of_S%26P_500_companies"))
noko = Nokogiri::HTML(html)
cells = noko.css("h2+table td:first-child a, h2+table td:nth-child(2) a")
cells.each_with_index do |cell, i|
  if i % 2 == 0
    stock = Stock.find_by(company: cells[i+1].text)
    begin
      price = MarketData.quote(cells[i].text).fetch("LastPrice")
    rescue Errno::ECONNRESET
    end
    if stock.nil?
      Stock.create(symbol: cells[i].text, company: cells[i+1].text, last_price: price)
    else
      stock.update_attributes(last_price: price)
    end
  end
end