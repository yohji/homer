require 'fileutils'

module FilesystemHelper

	def resources(path, ext = "")

		resources = []

		Dir.glob(path + "/*" + ext) do |f|
			resources.push(Resource.new(f, path))
		end
		
		return resources.sort
	end
	
	def expand(path)
		
		return File.expand_path("..", path)
	end
	
	def rm(path)
		
		FileUtils.rm_rf(path)
	end
end
