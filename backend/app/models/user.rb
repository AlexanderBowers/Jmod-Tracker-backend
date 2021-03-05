require 'pry'
class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    has_many :userjmods
    has_many :jmods, through: :userjmods
    has_many :tweets, through: :jmods
    has_many :comments, through: :jmods
    has_many :usertweets
    has_many :usercomments
    # has_many :tweets, through: :usertweets
    # has_many :comments, through: :usercomments

    # def get_tweets
    #     tweets = []
    #     if self.usertweets
    #         self.usertweets.map do |ut|
    #             tweets.push(ut.tweet)
    #         end
    #     end
    #     tweets
    # end

    # def get_comments
    #     comments = []
    #     if self.usercomments
    #         self.usercomments.map do |uc|
    #             comments.push(uc.comment)
    #         end
    #     end
    #     comments
    # end

    def get_tweets
        tweets = []
        if self.jmods
            self.jmods.map do |j|
                if j.tweets
                    j.tweets.map do |t|
                    tweets.push(t)
                    end
                end
            end
        end
        tweets
    end

    def get_comments
        comments = []
        if self.jmods
            self.jmods.map do |j|
                if j.comments
                    j.comments.map do |c|
                    comments.push(c)
                    end
                end
            end
        end
        comments
    end


    

end
