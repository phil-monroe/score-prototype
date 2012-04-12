class EventsController < ApplicationController
  respond_to :json

	def index
		respond_with Event.all
	end
	
	def create
		respond_with Event.create(params[:event])
	end
end