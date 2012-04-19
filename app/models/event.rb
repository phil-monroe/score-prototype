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
    self.by(who).in_pillar(pillar).between(range).select("sum(available_events.multiplier) as sum").map(&:attributes).first['sum'].to_i || 0
  end

  def self.energy(candidate_id)
		steps = 15
    (steps - self.where(:user_type => "Candidate", :user_id => candidate_id).where("created_at > ?", CalculationTimeHistory.last.time).count)*100/steps
  end

	def self.pillar_counts
		times = CalculationTimeHistory.last(2)
		events = self.where(:user_type => "Candidate").where("created_at > ?", times.first.time).where("created_at < ?", times.last.time)
		array = Pillar.all.collect{|p|
			count = events.where("available_event_id IN (?)", p.available_events.collect{|e| e.id}).count
			{p.name => count}
		}
		hash = {}
		array.each do |h|
			hash.merge! h
		end
		hash
	end
	
end

