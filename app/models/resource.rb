class Resource
	
	attr_accessor :absolute, :name, :size

	def initialize(path, name = nil)
		
		@absolute = path
		@name = name
		@size = stat.size
		
		if (@name.nil?)
			@name = File.basename(@absolute)
		end
	end
	
	def == other
		
		@absolute == other.absolute
	end
	
	def <=> other
		
		@absolute <=> other.absolute
	end
	
	def directory?
		
		File.directory?(@absolute)
	end
	
	def stat
		
		File.stat(@absolute)
	end
end
