require 'pry'
require 'json'
class User < ApplicationRecord

    def initialize(feed = {})
        @feed = feed
    end
    attr_accessor :feed

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
    def set_feed
        new_feed = {}
        Jmod.all.map do |j|
            new_feed[j.name] = {twitter: [], reddit: []}
            id = Search.get_id(j.name)
            #this is just grabbing the jmod's most recent tweet id and setting it as value to twitter key.
            twitter = Search.get_tweets(id["data"][0]["id"])
            new_feed[j.name][:twitter] = twitter["data"][0]["id"]
            #reddit when converted it comes out as
            #{data: {children: [{data: {body: text, permalink: text}}, {}, {}]}}
            #this is grabbing the most recent comment's id and assigning it to that jmod's reddit key.
            reddit = Search.get_reddit(j.name)
            reddit_json = JSON.parse(reddit)
            new_feed[j.name][:reddit] = reddit_json["data"]["children"][0]["data"]["id"] 
        end
        check_feed(new_feed)
    end

    def check_feed(new_feed)
        differences = []
        byebug
        if @feed == new_feed 
            differences
        else
            if @feed != nil
                #map through jmods. if it is different than the user's feed, push it to differences.
                new_feed.map do |j|
                    if j[:twitter] != @feed[j][:twitter] && j[:reddit] != @feed[j][:reddit]
                        differences.push("#{j}'s twitter and reddit")
                    elsif j[:twitter] != @feed[j][:twitter]
                        differences.push("#{j}'s twitter")
                    elsif j[:reddit] != @feed[j][:reddit]
                        differences.push("#{j}'s twitter")
                    end
                end
            else
                self.feed = new_feed
                differences = new_feed
            end
            self.feed = new_feed
            differences
        end
        differences
    end

end