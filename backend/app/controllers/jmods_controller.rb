class JmodsController < ApplicationController

    def index
        jmods = []
        Jmod.all.map do |j|
            jmods.push(j.name)
        end 
        render json: jmods
    end

    def create
        jmod = Jmod.new(name: params[:name])
        jmod.valid? ?
        jmod = Jmod.create(name: params[:name]) :
        jmod = Jmod.find_by(name: params[:name])
        render json: jmod
    end 
end
