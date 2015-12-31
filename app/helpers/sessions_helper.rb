module SessionsHelper
	include NavigationHelper

	def login(username)
		session[:user] = username
		nav_setup
	end

	def logout
		session.delete(:user)
		nav_clear
	end

	def current_user
		session[:user]
	end

	def logged_in?
		! current_user.nil?
	end
end
