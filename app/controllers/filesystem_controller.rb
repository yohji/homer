require 'mediainfo'

class FilesystemController < ApplicationController
	include FilesystemHelper, NavigationHelper
	
	def home
		
		redirect_to(action: :show, route: Route::DOWNLOAD)
	end
	
	def show
		
		@autodiv = true
		@filter = true
		
		@route = params[:route]
		if (@route == Route::DOWNLOAD)
			@autodiv = false
			@filter = false
		end
		
		path_raw = params[:path]
		check_access(path_raw, @route)
		
		if (path_raw.nil?)
			@path = nav_current(@route)
		else
			@path = nav_select(@route, path_raw)
		end
		
		@data = fs_resources(@path.absolute, @route)
	end
	
	def back
		
		route = params[:route]
		nav_back(route)
		
		redirect_to(action: :show, route: route)
	end
	
	def move
		
		path = params[:path]
		route = params[:route]
		loc = params[:location]
		
		if (File.directory?(path))
			nav_back(route)
		end
		
		fs_move(path, loc)
		
		redirect_to(action: :show, route: route)
	end
	
	def rename
		
		path = params[:path]
		route = params[:route]
		name = params[:name]
		
		if (File.directory?(path))
			curr = nav_current(route)
			curr.name = name
			curr.absolute = fs_expand(path) + "/" + name
		end
		
		fs_rename(path, name)

		redirect_to(action: :show, route: route)
	end
	
	def delete
		
		path = params[:path]
		route = params[:route]
		check_access(path, route)
		
		if (File.directory?(path))
			nav_back(route)
		end
		
		fs_rm(path)

		redirect_to(action: :show, route: route)
	end
	
	def info
		
		path = params[:path]
		@info = Media.new(Mediainfo.new(path))
		
		render json: @info
	end
	
	def tree
		
		@tree = {:name => "locations", :path => "-"}
		@tree[:child] = [
			fs_tree_dir(APP_CONFIG["locations"][Route::MOVIE]),
			fs_tree_dir(APP_CONFIG["locations"][Route::MUSIC]),
			fs_tree_dir(APP_CONFIG["locations"][Route::ISO]),
		]
		
		render json: @tree
	end
	
	private

	def check_access(path, route)
		
		if (! path.nil? && ! path.start_with?(nav_root(route).absolute))
			raise "Illegal access"
		end
	end
end
