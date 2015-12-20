class MovieController < ApplicationController
	include FilesystemService

	def show

		@data = list(APP_CONFIG["locations"]["movie"])
	end
end
