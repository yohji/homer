class FilesystemController < ApplicationController
	include FilesystemHelper
	
	def download
		
		@data = prepare("download")
	end
	
	def movie
		
		@data = prepare("movie")
	end
	
	def music
		
		@data = prepare("music")
	end
	
	def iso
		
		@data = prepare("iso")
	end

	private

	def prepare(location)

		path = params[:path]
		loc = APP_CONFIG["locations"][location]

		if (path == nil)
			path = loc

		elsif (! path.start_with?(loc))
			raise "Illegal access"
		end

		return list(path)
	end
end
