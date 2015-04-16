# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'yaml'

items = YAML::load File.new('db/item.yml').read
items.each do |item_data|
  item_hash = item_data.second
  item = Item.new(item_hash)
  price_delta = item.original_price.to_f * 0.2
  min_price = item.original_price.to_f - price_delta
  max_price = item.original_price.to_f + price_delta
  30.times do 
    item.listings.build(price: rand(min_price..max_price).round(2))
  end
  item.save!
end