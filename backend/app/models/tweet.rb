class Tweet < ApplicationRecord
  belongs_to :jmod
  belongs_to :userjmods, through: :jmods
  belongs_to :users, through: :userjmods
  validates :url, uniqueness: true
end
