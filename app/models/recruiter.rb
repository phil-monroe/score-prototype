class Recruiter < ActiveRecord::Base
  has_many :events, as: :recruiter
end
