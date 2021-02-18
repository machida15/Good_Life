module NotificationsHelper

  def notification_form(notification)
      @visiter = notification.visiter
      @comment = nil
      @tweet = link_to 'あなたの投稿', tweet_path(notification), style:"font-weight: bold;"
      @visiter_tweet_comment = notification.tweet_comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favorite" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にいいねしました"
        when "tweet_comment" then
            @comment = TweetComment.find_by(id: @visiter_comment)&.content
            tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.tweet_id), style:"font-weight: bold;")+"にコメントしました"
      end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end


end
