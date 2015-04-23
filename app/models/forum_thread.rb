# == Schema Information
#
# Table name: forum_threads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  content    :text
#
# Indexes
#
#  index_forum_threads_on_user_id  (user_id)
#

class ForumThread < ActiveRecord::Base
  acts_as_paranoid 
  is_impressionable
  
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  has_many :users, through: :forum_posts

  validates :subject, presence: true
  validates :content, presence: true
  validates_associated :forum_posts


  def num_of_replies
    forum_posts.count
  end
end
