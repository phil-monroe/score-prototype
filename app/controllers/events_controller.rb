class EventsController < ApplicationController
	def index
		@events = Event.all
		respond_to do |format|
			format.json {render :json => @events}
			format.csv	{ 
				@models = @events
				render '/shared/index'
			}		
		end
	end
	
	def create		
    if Event.energy(params[:event][:user_id]) > 0
      e = Event.create(params[:event])
    end
		render :json => {energy: Event.energy(params[:event][:user_id])}.to_json
	end
end
