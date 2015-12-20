class ApplicationController < ActionController::Base
	include SessionsHelper

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :check_login

	def check_login

		if (request.env['PATH_INFO'] != "/login" && ! logged_in?)
			redirect_to login_path
		end
	end
end
