# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_user_id  (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: {maximum: 2000}
end
