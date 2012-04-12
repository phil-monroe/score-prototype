class Admin::PillarsController < ApplicationController

  active_scaffold :pillar do |config|
    config.label = "pillars"
    config.columns = [:id, :name, :weight]
    config.create.columns = [:name, :weight]
    config.update.columns = [:name, :weight]
  end

end
