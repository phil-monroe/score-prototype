class AvailableEventsController < ApplicationController
  respond_to :json

	def index
		if params['user_type']
			respond_with AvailableEvent.where user_type: params["user_type"]
		else
			respond_with AvailableEvent.all
		end		
	end
end