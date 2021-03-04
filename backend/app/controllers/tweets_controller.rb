class TweetsController < ApplicationController

    def index

    end

    def create
        #check if there is an existing Userjmod
        #if there is, cool beans.
        #if there isn't, create one.
        #check if tweet is valid.
        #if it is,  return success.
        #if it isn't, return error.
        byebug
        Userjmod.find_by(user_id: current_user.id, jmod_id: params[:jmod_id]) ? null : Userjmod.create(user_id: current_user.id, jmod_id: params[:jmod_id])
        tweet = Tweet.new(body: params[:body], url: params[:url], jmod_id: params[:jmod_id])
        tweet.valid? ?
        tweet = Tweet.create(body: params[:body], url: params[:url], jmod_id: params[:jmod_id]) && response = {success: "Pin created"}
        : response = {error: "Cannot create second pin for this tweet."}
        render json: response
    end

    def destroy

    end

end
