class FilesystemController < ApplicationController
	include FilesystemHelper, NavigationHelper
	
	def home
		
		redirect_to(action: :show, route: ROUTE_DOWNLOAD)
	end
	
	def show
		
		@autodiv = true
		@filter = true
		
		@route = params[:route]
		if (@route == ROUTE_DOWNLOAD)
			@autodiv = false
			@filter = false
		end
		
		path_raw = params[:path]
		if (path_raw == nil)
			@path = nav_current(@route)

		elsif (! path_raw.start_with?(nav_root(@route).absolute))
			raise "Illegal access"
			
		else
			@path = nav_select(@route, path_raw)
		end
		
		@data = fs_resources(@path.absolute)
	end
	
	def delete
		
		path = params[:path]
		route = params[:route]
		
		if (! path.start_with?(nav_root(route).absolute))
			raise "Illegal access"
		end
		
		if (File.directory?(path))
			redir = nav_back(route)
		else
			redir = fs_expand(path)
		end
		
		fs_rm(path)

		redirect_to(action: :show, route: route, path: redir)
	end
end
