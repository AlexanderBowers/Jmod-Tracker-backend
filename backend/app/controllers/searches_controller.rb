class SearchesController < ApplicationController

    def get_request
        id = Search.get_id(params[:name])
        request = Search.get_tweets(id["data"][0]["id"])
        render json: request
    end 

    def get_reddit
        jmod = Search.get_reddit(params[:name])
        render json: jmod
    end
        
end
