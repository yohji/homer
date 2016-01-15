require 'fileutils'

module FilesystemHelper
	
	def fs_setup
		
		sort = Hash.new
		
		sort[Route::DOWNLOAD] = Sort::NAME
		sort[Route::MOVIE] = Sort::NAME
		sort[Route::MUSIC] = Sort::NAME
		sort[Route::ISO] = Sort::NAME
		
		session[:sort] = sort
	end
	
	def fs_clear
		
		session.delete(:sort)
	end
	
	def fs_set_sort(route, sort)
		
		session[:sort][route] = sort
	end
	
	def fs_get_sort(route)
		
		session[:sort][route]
	end
	
	def fs_resources(path, route)

		resources = []
		Dir.glob(path + "/*") do |f|
			resources.push(Resource.new(f))
		end
		
		sort = fs_get_sort(route)
		if (sort == Sort::NAME)
			
			resources.sort! do |x, y| 
				x.absolute.downcase <=> y.absolute.downcase
			end
			
		elsif (sort == Sort::SIZE)
		
			resources.sort! do |x, y| 
				x.size <=> y.size
			end
			resources.reverse!
			
		elsif (sort == Sort::DATE)
		
			resources.sort! do |x, y| 
				x.date <=> y.date
			end
			resources.reverse!
		end
		
		return resources
	end
	
	def fs_expand(path)
		
		return File.expand_path("..", path)
	end
	
	def fs_rm(path)
		
		FileUtils.rm_rf(path)
	end
	
	def fs_rename(path, name)

		base = fs_expand(path)
		File.rename(path, "#{base}/#{name}")
	end
	
	def fs_move(path, location)
		
		FileUtils.mv(path, location)
	end
	
	def fs_makedir(path)
		
		Dir.mkdir(path);
	end
	
	def fs_tree_dir(path)
		
		fs_tree(path, nil, true);
	end
	
	def fs_tree(path, name = nil, only_dir = false)
		
		name = File.basename(path) if name.nil?
		
		tree = {:name => name, :path => path}
		tree[:child] = child = []
		
		Dir.foreach(path) do |entry|
			
			next if (entry == '..' || entry == '.')
			full_path = File.join(path, entry)
			
			if File.directory?(full_path)
				child << fs_tree(full_path, entry, only_dir)
				
			elsif (! only_dir)
				child << entry
			end
		end
		
		return tree
	end
end
