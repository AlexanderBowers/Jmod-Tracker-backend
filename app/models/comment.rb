class Comment < ApplicationRecord
  belongs_to :jmod
  has_many :usercomments
  validates :permalink, uniqueness: true
end
