class Tweet < ApplicationRecord

  belongs_to :user
  attachment :image
  has_many :tweet_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :favorites, dependent: :destroy

  validates :body, presence: true

# いいね機能
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          tweet_id: id,
          visited_id: user_id,
          action: "favorite"
        )
        notification.save if notification.valid?
  end
# 通知機能
  def create_notification_comment!(current_user, comment_id)
        # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = TweetComment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end
        # まだ誰もコメントしていない場合は、投稿者に通知を送る
        save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, tweet_comment_id, visited_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
          tweet_id: id,
          tweet_comment_id: tweet_comment_id,
          visited_id: visited_id,
          action: 'tweet_comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
  end

end
