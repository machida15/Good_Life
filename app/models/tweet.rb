class Tweet < ApplicationRecord

  belongs_to :user
  attachment :image
  has_many :tweet_comments, dependent: :destroy

end
