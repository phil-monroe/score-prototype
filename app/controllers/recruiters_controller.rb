class RecruitersController < ApplicationController
  def show
    @recruiter = Recruiter.find(params[:id])
		@candidates = Candidate.order('score DESC')
    respond_to do |format|
			format.html
			format.json { render :json => @recruiter }
		end  
	end
  
  def update
    respond_to do |format|
			format.json { render :json => @recruiter }
		end
  end
  
end