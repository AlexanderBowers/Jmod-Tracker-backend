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
        byebugoa
        jmod = Jmod.find_by(name: params[:jmod])
         if Userjmod.find_by(user_id: user, jmod_id: jmod.id) == nil
            Userjmod.create(user_id: user, jmod_id: jmod.id)
         end

        Comment.find_by(body: params[:body], permalink: params[:permalink], jmod_id: jmod.id) ?
            (comment = Comment.find_by(body: params[:body], url: params[:url], jmod_id: jmod.id)
            Usercomment.find_by(user_id: user, comment_id: comment.id) ?
                response = {error: 'pin exists'} :
                Usercomment.create(user_id: user, comment_id: comment.id) && response = {success: "Pin created"}) :
           (comment = Comment.create(body: params[:body], permalink: params[:permalink], jmod_id: jmod.id)
            Usercomment.create(user_id: user, comment_id: comment.id) && response = {success: "Pin created"})
        render json: response
    end

    def destroy
        #for presentation, just destroy comment.
        #after graduation, change so it just destroys Usercomment.
        
        comment = Comment.find_by(id: params["id"])
        comment.destroy()
        render json: {message: 'comment destroyed'}
    end

end