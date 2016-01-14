class Resource
	
	attr_accessor :absolute, :name, :size, :date

	def initialize(path, name = nil)
		
		@absolute = path
		@name = name
		@size = directory? ? -1 : stat.size
		@date = stat.ctime
		
		if (@name.nil?)
			@name = File.basename(@absolute)
		end
	end
	
	def == other
		
		@absolute == other.absolute
	end
	
	def directory?
		
		File.directory?(@absolute)
	end
	
	def stat
		
		File.stat(@absolute)
	end
end
