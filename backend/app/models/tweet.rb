class Tweet < ApplicationRecord
  belongs_to :jmod
  has_many :usertweets
  validates :url, uniqueness: true
end
