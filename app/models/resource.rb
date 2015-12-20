class Resource
	
	attr_reader :absolute, :path, :name

	def initialize(filename, path)
		
		@absolute = filename.dup
		@stat = File.stat(@absolute)

		@path = path
		filename.slice!(path + "/")
		@name = filename
	end
	
	def <=> other
		
		@absolute <=> other.absolute
	end
	
	def directory?
		
		File.directory?(@absolute)
	end
	
	def size
		@stat.size
	end
end
