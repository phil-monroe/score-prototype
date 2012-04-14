class Event < ActiveRecord::Base
  belongs_to :user, :polymorphic => true
  belongs_to :available_event

	validates_presence_of :user_id
	validates_presence_of :user_type
	validates_presence_of :available_event_id
	


  scope :by, lambda { |who|
    if who.is_a? Class
      where(:user_type => who)
    else
      where(:user_type => who.class, :user_id => who.id)
    end
  }
  scope :in_pillar, lambda {|pillar| joins(:available_event).where("available_events.pillar_id = #{pillar.id}") }

  scope :between, lambda{|range| where(:created_at => (range.first..range.last))}

  def self.total_activity who, pillar, range
    self.by(who).in_pillar(pillar).between(range).select("sum(available_events.multiplier) as sum").map(&:attributes).first['sum'] || 0
  end

  def self.energy(candidate_id)
    (20 - self.where(:user_type => "Candidate", :user_id => candidate_id).where("created_at > ?", CalculationTimeHistory.last.time).count)*5
  end
end
