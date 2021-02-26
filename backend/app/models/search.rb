require 'optparse'
require "net/http"
require 'net/https'
require "base64"
require 'json'
require "webrick"

class Search < ApplicationRecord
    TWITTER_BEARER_KEY = ENV['twitter_bearer_key']

    def self.get_id(name)
        $options = { 
            :port => 5000, 
            :host => '127.0.0.1', 
            :sslverify => true,
            :root => '.' }
        uri = URI.parse("https://api.twitter.com/2/users/by?usernames=#{name}")
        req = Net::HTTP::Get.new(uri)
        #  Construct the Authorization Header
        req['Authorization'] = "Bearer #{TWITTER_BEARER_KEY}"
        req['Accept'] = "application/json"
        sock = Net::HTTP.new(uri.host, uri.port)
        if $options[:sslverify] == true or $options[:sslverify] = "true"
            sock.use_ssl = true
        else
            sock.use_ssl = false
        end
        sock.verify_mode = OpenSSL::SSL::VERIFY_NONE
        res = sock.start {|http| http.request(req) }
        results_obj = JSON.parse(res.body)
    end


    def self.get_tweets(id)
        
        $options = { 
            :port => 5000, 
            :host => '127.0.0.1', 
            :sslverify => true,
            :root => '.' }
        uri = URI.parse("https://api.twitter.com/2/users/#{id}/tweets?tweet.fields=created_at&expansions=author_id&user.fields=created_at&max_results=10")
        req = Net::HTTP::Get.new(uri)
        #  Construct the Authorization Header
        req['Authorization'] = "Bearer #{TWITTER_BEARER_KEY}"
        req['Accept'] = "application/json"
        sock = Net::HTTP.new(uri.host, uri.port)
        if $options[:sslverify] == true or $options[:sslverify] = "true"
            sock.use_ssl = true
        else
            sock.use_ssl = false
        end
        sock.verify_mode = OpenSSL::SSL::VERIFY_NONE
        res = sock.start {|http| http.request(req) }
        results_obj = JSON.parse(res.body)
    end
end
