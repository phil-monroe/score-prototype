class EnergyController < ApplicationController
  respond_to :json

	def index

    render :json => {energy: Event.energy(params[:candidate_id])}.to_json
	end
end
