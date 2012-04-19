class Admin::SettingsController < ApplicationController
	def index
		if params["show_counts"].present?
			if params[:show_counts] == "true"
				Rails.cache.write(:show_counts, true)
			elsif params[:show_counts] == "false"
				Rails.cache.write(:show_counts, false)
			end
			redirect_to admin_settings_path
		end
	end
end