class CandidatesController < ApplicationController
	def index
		respond_to do |format|
			format.json { render :json => Candidate.order('score ASC').all }
		end
	end
  def show
    @candidate = Candidate.find(params[:id])
    respond_to do |format|
			format.html
			format.json { render :json => @candidate }
		end  
	end
  
  def update
    respond_to do |format|
			format.json { render :json => @candidate }
		end
  end
  
end