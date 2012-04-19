class RawScoreHistory < ActiveRecord::Base
  belongs_to :candidate
  serialize :pillars, Hash

	def pillars(with_counts=true)
		if with_counts
			pillars = super()
			
		else
			super()
		end
	end
end
