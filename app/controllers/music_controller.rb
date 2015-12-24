class MusicController < ApplicationController
	include FilesystemHelper

	def show

		path = params[:path]
		loc = APP_CONFIG["locations"]["music"]

		if (path == nil)
			path = loc

		elsif (! path.start_with?(loc))
			raise "Illegal access"
		end

		@data = list(path)
	end
end
