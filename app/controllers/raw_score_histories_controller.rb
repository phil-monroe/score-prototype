class RawScoreHistoriesController < ApplicationController
  respond_to :json

	def index
    respond_with Candidate.find(params[:candidate_id]).raw_score_histories.order('updated_at DESC').limit(20), :status => :ok
	end
end
