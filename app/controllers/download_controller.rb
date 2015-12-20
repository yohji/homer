load "filesystem_service.rb"

class DownloadController < ApplicationController
	include FilesystemService

	def show
		
		@data = list(APP_CONFIG["locations"]["download"])
	end
end
