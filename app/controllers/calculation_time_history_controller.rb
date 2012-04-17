class CalculationTimeHistoryController < ApplicationController
  respond_to :json
  
	def index
		last2 = CalculationTimeHistory.last(2)
		last_time = last2.last.updated_at
		interval  = last_time - last2.first.updated_at
		next_time = last_time + interval
		respond_with last_time: last_time, interval: interval.round, next_time: next_time
	end
  
end