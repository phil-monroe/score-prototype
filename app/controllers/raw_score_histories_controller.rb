class RawScoreHistoriesController < ApplicationController
	
	def index
		if params[:candidate_id]
			respond_to do |format|
				format.json {
						render :json => Candidate.find(params[:candidate_id]).raw_score_histories.order('updated_at DESC').limit(20), :status => :ok
				}
			end
		else
			respond_to do |format|
				format.csv	{ 
					@models = RawScoreHistory.all
					render '/shared/index'
				}
			end	
		end
	end
end
