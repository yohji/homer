module NavigationHelper
	
	ROUTE_DOWNLOAD = "download"
	ROUTE_MOVIE = "movie"
	ROUTE_MUSIC = "music"
	ROUTE_ISO = "iso"
	
	def nav_setup
		
		nav = Hash.new
		nav[ROUTE_DOWNLOAD] = [Resource.new(APP_CONFIG["locations"][ROUTE_DOWNLOAD], "/")]
		nav[ROUTE_MOVIE] = [Resource.new(APP_CONFIG["locations"][ROUTE_MOVIE], "/")]
		nav[ROUTE_MUSIC] = [Resource.new(APP_CONFIG["locations"][ROUTE_MUSIC], "/")]
		nav[ROUTE_ISO] = [Resource.new(APP_CONFIG["locations"][ROUTE_ISO], "/")]
		
		session[:navigation] = nav
	end
	
	def nav_clear
		
		session.delete(:navigation)
	end
	
	def nav_breadcrumb(route)
		
		return session[:navigation][route]
	end

	def nav_select(route, path)
		
		bc = nav_breadcrumb(route)
		first = bc.first
		
		if (path == first.absolute)
			
			bc.clear
			bc.push(first)
			
			return first
		end
		
		curr = Resource.new(path)
		
		idx = (bc.size - 1)
		pos = -1
		bc.reverse_each do |p| 
			
			if (p == curr)
				pos = idx
				break
			end
			
			idx -= 1
		end
		
		if (pos != -1)
			while (bc.size > (pos + 1)) do 
				bc.pop
			end
		else
			bc.push(curr)
		end
		
		return curr
	end
	
	def nav_back(route)

		bc = nav_breadcrumb(route)
		if (bc.size > 1)
			bc.pop
		end
	end
	
	def nav_current(route)
		
		nav_breadcrumb(route).last
	end
	
	def nav_root(route)
		
		nav_breadcrumb(route).first
	end
end
