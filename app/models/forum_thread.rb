class ForumThread < ActiveRecord::Base
  acts_as_paranoid 
  
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  has_many :users, through: :forum_posts

  accepts_nested_attributes_for :forum_posts

  validates :subject, presence: true
  validates_associated :forum_posts


  def num_of_replies
    forum_posts.count
  end
end
