class Event < ActiveRecord::Base
  belongs_to :user, :polymorphic => true
  belongs_to :available_event

  scope :by, lambda { |who|
    if who.is_a? Class
      where(:user_type => who)
    else
      where(:user_type => who.class, :user_id => who.id)
    end
  }
  scope :in_pillar, lambda {|pillar| joins(:available_event).where("available_events.pillar_id = #{pillar.id}") }

  def self.total_activity who, pillar
    self.by(who).in_pillar(pillar).select("sum(available_events.multiplier) as sum").map(&:attributes).first['sum']
  end
end
