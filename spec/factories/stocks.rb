# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  symbol     :string
#  company    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  last_price :float
#

FactoryGirl.define do
  factory :stock do
    
  end

end
