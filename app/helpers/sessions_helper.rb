module SessionsHelper
	include NavigationHelper, FilesystemHelper

	def login(username)
		
		session[:user] = username
		nav_setup
		fs_setup
	end

	def logout
		
		session.delete(:user)
		nav_clear
		fs_clear
	end

	def current_user
		
		session[:user]
	end

	def logged_in?
		
		! current_user.nil?
	end
end
