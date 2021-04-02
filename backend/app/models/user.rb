require 'pry'
require 'json'
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

    # //response comes out as
    # //{data: {children: [{data: {body: text, permalink: text}}, {}, {}]}}
    # //to generate link to comment:
    # //https://reddit.com/${permalink}
    # //if user isn't found, response is {message: "Not Found"}

    #checks the feed against a user's saved feed
    #to see if there are updates
    @feed = {}

    def get_feed
        new_feed = {}
        Jmod.all.map do |j|
            new_feed[j.name] = {twitter: [], reddit: []}
            #for each jmod, search twitter
            #for all their tweets & comments, save into @feed[j: {twitter: [], reddit:[]}]
            id = Search.get_id(j.name)
            
            twitter = Search.get_tweets(id["data"][0]["id"])
            new_feed[j.name][:twitter] = twitter["data"].first
            

            reddit = Search.get_reddit(j.name)
            reddit_json = JSON.parse(reddit)
            new_feed[j.name][:reddit] = reddit
            byebug
        end
            @feed = new_feed
    end
end
