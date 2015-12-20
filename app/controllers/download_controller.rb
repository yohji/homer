class DownloadController < ApplicationController
	include FilesystemHelper

	def show

		path = params[:path]
		download = APP_CONFIG["locations"]["download"]

		if (path == nil)
			path = download

		elsif (! path.start_with?(download))
			raise "Illegal access"
		end

		@data = list(path)
	end
end
