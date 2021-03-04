class CommentsController < ApplicationController

    def index

    end

    def create
        #check if there is an existing Userjmod
        #if there is, cool beans.
        #if there isn't, create one.
        #check if comment currently exists.
        #if it does, check if Usercomment exists. If it does, return error. If it doesn't, create new Usercomment.
        #if it doesn't, create comment then create new Usercomment.
        user = current_user.id
        jmod = params[:jmod_id]
         if Userjmod.find_by(user_id: user, jmod_id: jmod) == nil
            Userjmod.create(user_id: user, jmod_id: jmod)
         end

        Comment.find_by(body: params[:body], url: params[:url], jmod_id: jmod) ?
            (comment = Comment.find_by(body: params[:body], url: params[:url], jmod_id: jmod)
            Usercomment.find_by(user_id: user, comment_id: comment.id) ?
                response = {error: 'pin exists'} :
                Usercomment.create(user_id: user, comment_id: comment.id) && response = {success: "Pin created"}) :
           (comment = Comment.create(body: params[:body], url: params[:url], jmod_id: jmod)
            Usercomment.create(user_id: user, comment_id: comment.id) && response = {success: "Pin created"})
        render json: response
    end

    def destroy

    end

end