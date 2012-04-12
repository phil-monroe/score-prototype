class Admin::AvailableEventsController < ApplicationController

  active_scaffold :available_event do |config|
    config.label = "available_event"
    config.columns = [:id, :event_name, :user_type, :pillar_id, :multiplier]
    config.create.columns = [:event_name, :user_type, :pillar_id, :multiplier]
    config.update.columns = [:event_name, :user_type, :pillar_id, :multiplier]
  end

end
