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
