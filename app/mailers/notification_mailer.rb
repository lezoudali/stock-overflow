class NotificationMailer < ApplicationMailer

  def forum_post_notification(user, forum_post)
    @user = user
    @forum_post = forum_post

    mail(
      to: "#{@user.email}",
      subject: "[StockOverflow] New post in #{@forum_post.forum_thread.subject}"
    )
  end
end
