require 'pry'
require 'json'
class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true

    has_many :userjmods
    has_many :jmods, through: :userjmods
    has_many :tweets, through: :jmods
    has_many :comments, through: :jmods

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

    

    #checks the feed against a user's current feed, then sets the new feed, and returns the difference. 
    #for each jmod, search twitter & reddit. save their most recent tweet and comment id
    def set_feed(jmods)
        new_feed = {}
        jmods.map do |j|
            new_feed[j] = {twitter: [], reddit: []}
            id = Search.get_id(j)
            #this is just grabbing the jmod's most recent tweet id and setting it as value to twitter key.
            twitter = Search.get_tweets(id["data"][0]["id"])
            new_feed[j][:twitter] = twitter["data"][0]["id"]
            #reddit when converted it comes out as
            #{data: {children: [{data: {body: text, permalink: text}}, {}, {}]}}
            #this is grabbing the most recent comment's id and assigning it to that jmod's reddit key.
            reddit = Search.get_reddit(j)
            reddit_json = JSON.parse(reddit)
            if reddit_json["data"] != nil
                if reddit_json["data"]["children"].length > 0
                    new_feed[j][:reddit] = reddit_json["data"]["children"][0]["data"]["id"]
                end
            end 
        end
        new_feed
    end

    # def check_feed(new_feed, old_feed)
    #     differences = {new_feed: new_feed, updates: []}
    #     old_feed = JSON.parse(old_feed)
    #     byebug
    #     if old_feed == new_feed 
    #         differences[:updates] = "there are no new updates"
    #     else
    #         #map through jmods in new_feed. if it is different than the user's old_feed, push it to differences.
    #         new_feed.map do |j|
    #             if j[:twitter] != old_feed[j][:twitter] && j[:reddit] != old_feed[j][:reddit]
    #                 differences[:updates].push("#{j}'s twitter and reddit")
    #             elsif j[:twitter] != old_feed[j][:twitter]
    #                 differences[:updates].push("#{j}'s twitter")
    #             elsif j[:reddit] != old_feed[j][:reddit]
    #                 differences[:updates].push("#{j}'s twitter")
    #             end
    #         end
    #         differences
    #     end
    #     differences
    # end

end