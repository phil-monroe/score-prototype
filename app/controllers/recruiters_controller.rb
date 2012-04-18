class RecruitersController < ApplicationController
	def index
		respond_to do |format|
			format.csv	{ 
				@models = Recruiter.all
				render '/shared/index'
			}
		end
	end
	
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