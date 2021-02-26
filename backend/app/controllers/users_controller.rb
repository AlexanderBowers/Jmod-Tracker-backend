class UsersController < ApplicationController

    def index 
        user = User.all 
        render json: user
    end


    def get_request
        id = User.get_id(params[:name])
        request = User.get_tweets(id["data"][0]["id"])
        render json: request
    end 
        
end
