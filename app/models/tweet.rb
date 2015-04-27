# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  text       :string
#  url        :string
#  stock_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tweets_on_stock_id  (stock_id)
#

class Tweet < ActiveRecord::Base
  belongs_to :stock
end
