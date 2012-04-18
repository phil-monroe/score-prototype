class AvailableEventsController < ApplicationController
	def index
		respond_to do |format|
			format.json {
				if params['user_type']
					render :json => AvailableEvent.where(user_type: params["user_type"])
				else
					render :json => AvailableEvent.all
				end
			}
			format.csv	{ 
				@models = AvailableEvent.all
				render '/shared/index'
			}
		end
	end
end