require 'fileutils'

module FilesystemHelper

	def fs_resources(path, ext = "")

		resources = []

		Dir.glob(path + "/*" + ext) do |f|
			resources.push(Resource.new(f))
		end
		
		return resources.sort
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
