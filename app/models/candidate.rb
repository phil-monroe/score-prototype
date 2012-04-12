class Candidate < ActiveRecord::Base
  has_many :events, as: :user
  has_many :raw_score_histories

  def self.active_in range
    Candidate.find(Event.by(Candidate).between(range).map(&:user_id).uniq)
  end
end
