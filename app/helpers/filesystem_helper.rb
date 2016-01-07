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
		
		FileUtils.mv(path, APP_CONFIG["locations"][location])
	end
end
