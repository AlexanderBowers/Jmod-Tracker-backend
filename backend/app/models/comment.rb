class Comment < ApplicationRecord
  belongs_to :jmod
  has_many :usercomments
  validates :url, uniqueness: true
end
