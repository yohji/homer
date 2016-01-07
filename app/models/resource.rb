class Resource
	
	attr_accessor :absolute, :name

	def initialize(path, name = nil)
		
		@absolute = path
		@name = name
		
		if (@name == nil)
			@name = File.basename(@absolute)
		end
	end
	
	def == other
		
		@absolute == other.absolute
	end
	
	def <=> other
		
		@absolute <=> other.absolute
	end
	
	def stat
		
		File.stat(@absolute)
	end
	
	def directory?
		
		File.directory?(@absolute)
	end
	
	def size
		
		stat.size
	end
end
