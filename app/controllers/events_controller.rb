class EventsController < ApplicationController
  respond_to :json

	def index
		respond_with Event.all
	end
	
	def create
    if Event.energy(params[:event][:user_id]) > 0
      e = Event.create(params[:event])
    end
		render :json => {energy: Event.energy(params[:event][:user_id])}.to_json
	end
end
