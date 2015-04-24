# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  stock_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text
#

class Message < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user




end
