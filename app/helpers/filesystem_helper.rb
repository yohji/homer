require 'fileutils'

module FilesystemHelper

	def fs_resources(path, ext = "")

		resources = []

		Dir.glob(path + "/*" + ext) do |f|
			resources.push(Resource.new(f, path))
		end
		
		return resources.sort
	end
	
	def fs_expand(path)
		
		return File.expand_path("..", path)
	end
	
	def fs_rm(path)
		
		FileUtils.rm_rf(path)
	end
end
