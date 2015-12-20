module SessionsHelper

	def login(username)
		session[:user] = username
	end

	def logout
		session.delete(:user)
	end

	def current_user
		session[:user]
	end

	def logged_in?
		! current_user.nil?
	end
end
