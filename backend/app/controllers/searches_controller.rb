class SearchesController < ApplicationController

    def get_request
        byebug
        id = Search.get_id(params[:name])
        request = Search.get_tweets(id["data"][0]["id"])
        render json: request
    end 

    def get_reddit
        jmod = Search.get_reddit(params[:name])
        render json: jmod
    end

    def set_feed
        user = current_user
        byebug
        feed = user.set_feed(params[:old_feed])
        render json: feed
    end
        
end
