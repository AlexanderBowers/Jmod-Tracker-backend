class TweetsController < ApplicationController

    def index

    end

    def create
        #check if there is an existing Userjmod
        #if there is, cool beans.
        #if there isn't, create one.
        #check if tweet currently exists.
        #if it does, check if Usertweet exists. If it does, return error. If it doesn't, create new Usertweet.
        #if it doesn't, create tweet then create new Usertweet.
        user = current_user.id
        jmod = params[:jmod_id]
         if Userjmod.find_by(user_id: user, jmod_id: jmod) == nil
            Userjmod.create(user_id: user, jmod_id: jmod)
         end

        Tweet.find_by(body: params[:body], url: params[:url], jmod_id: jmod) ?
            (tweet = Tweet.find_by(body: params[:body], url: params[:url], jmod_id: jmod)
            Usertweet.find_by(user_id: user, tweet_id: tweet.id) ?
                response = {error: 'pin exists'} :
                Usertweet.create(user_id: user, tweet_id: tweet.id) && response = {success: "Pin created"}) :
           (tweet = Tweet.create(body: params[:body], url: params[:url], jmod_id: jmod)
            Usertweet.create(user_id: user, tweet_id: tweet.id) && response = {success: "Pin created"})
        render json: response
    end

    def destroy

    end

end