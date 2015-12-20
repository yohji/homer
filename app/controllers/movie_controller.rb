class MovieController < ApplicationController
	include FilesystemHelper

	def show

		@data = list(APP_CONFIG["locations"]["movie"])
	end
end
