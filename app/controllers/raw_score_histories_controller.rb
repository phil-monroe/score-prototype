class RawScoreHistoriesController < ApplicationController
	
	def index
		if params[:candidate_id]
			respond_to do |format|
				format.json {
					hists = Candidate.find(params[:candidate_id]).raw_score_histories.order('updated_at DESC').limit(20).collect{|h| h.attributes}
					hists[0][:pillar_counts] = Rails.cache.read(:show_counts) ? Event.pillar_counts : {}
						render :json => hists, :status => :ok
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
