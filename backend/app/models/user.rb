class User < ApplicationRecord
    has_secure_password
    validates :name, uniqueness: true
    has_many :userjmods
    has_many :jmods, through: :userjmods
    has_many :tweets, through: :jmods

end
