class MusicController < ApplicationController
	include FilesystemService

	def show

		@data = list(APP_CONFIG["locations"]["music"], "")
	end
end
