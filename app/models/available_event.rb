class AvailableEvent < ActiveRecord::Base
  has_many :events
  belongs_to :pillar 
end
