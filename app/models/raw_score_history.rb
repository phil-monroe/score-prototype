class RawScoreHistory < ActiveRecord::Base
  belongs_to :candidate
  serialize :pillars, Hash
end
