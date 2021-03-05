class Tweet < ApplicationRecord
  belongs_to :jmod
  has_many :usertweets
  validates :tweet_id, uniqueness: true
end
