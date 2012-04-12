class Candidate < ActiveRecord::Base
  has_many :events, as: :user
  has_many :raw_score_histories
end
