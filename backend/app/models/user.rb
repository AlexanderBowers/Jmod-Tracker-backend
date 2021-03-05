require 'pry'
class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    has_many :userjmods
    has_many :jmods, through: :userjmods
    #has_many :tweets, through: :jmods
    #has_many :comments, through: :jmods
    has_many :usertweets
    has_many :usercomments
    has_many :tweets, through: :usertweets
    has_many :comments, through: :usercomments
    

end
