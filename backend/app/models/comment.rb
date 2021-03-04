class Comment < ApplicationRecord
  belongs_to :jmod
  belongs_to :user, through: :jmod
  validates :url, uniqueness: true
end
