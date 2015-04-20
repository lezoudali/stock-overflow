# == Schema Information
#
# Table name: forum_posts
#
#  id              :integer          not null, primary key
#  forum_thread_id :integer
#  user_id         :integer
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_forum_posts_on_forum_thread_id  (forum_thread_id)
#  index_forum_posts_on_user_id          (user_id)
#

class ForumPost < ActiveRecord::Base
  belongs_to :forum_thread
  belongs_to :user

  validates :body, presence: true

  def user
    User.unscoped { super }
  end

  def send_notifications!
    users = forum_thread.users.uniq - [user]
    users.each do |user|
      NotificationMailer.forum_post_notification(user, self).deliver_now
    end
  end
end
