class MusicController < ApplicationController
	include FilesystemHelper

	def show

		@data = list(APP_CONFIG["locations"]["music"], "")
	end
end
