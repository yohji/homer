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
	
	def delete
		
		path = params[:path]
		loc = APP_CONFIG["locations"][params[:route]]
		if (! path.start_with?(loc))
			raise "Illegal access"
		end
		
		redir = expand(path)
		rm(path)

		redirect_to(action: params[:route], path: redir)
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

		return resources(path)
	end
end
