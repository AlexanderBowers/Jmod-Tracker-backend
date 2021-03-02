class Jmod < ApplicationRecord
    has_many :userjmods
    has_many :comments
    has_many :tweets
    validates :name, uniqueness: true
end