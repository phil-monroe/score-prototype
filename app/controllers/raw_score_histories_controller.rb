class RawScoreHistoriesController < ApplicationController
  respond_to :json

	def index
    respond_with Candidate.find(params[:candidate_id]).raw_score_histories.last(20)
	end
end
