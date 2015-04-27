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

FactoryGirl.define do
  factory :tweet do
    text "MyString"
url "MyString"
stock nil
  end

end
