require 'find'

module FilesystemHelper

	def list(path, ext = "")

		resources = []

		Dir.glob(path + "/*" + ext) do |f|
			resources.push(Resource.new(f, path))
		end
		
		return resources.sort
	end
end
