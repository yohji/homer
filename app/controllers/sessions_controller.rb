class SessionsController < ApplicationController

	def show
	end

	def create

		APP_CONFIG["users"].each do |user|

			if (user["username"] == params[:session][:username].downcase && user["password"] == params[:session][:password])
				login user["username"]
				redirect_to root_path
				return
			end
		end

		flash.now[:danger] = 'Invalid username/password combination'

		render 'new'
	end

	def destroy

		logout
		redirect_to login_path
	end
end
