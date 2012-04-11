class Event < ActiveRecord::Base
  belongs_to :user, :polymorphic => true
  belongs_to :available_event
end
