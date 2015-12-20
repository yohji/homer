class MovieController < ApplicationController
	include FilesystemService

	def show

		@data = list(APP_CONFIG["locations"]["movie"], ".{avi,mp4,mkv}")
	end
end
