class Path
	
	attr_reader :absolute, :name

	def initialize(path, name = nil)
		
		@absolute = path
		@name = name
		
		if (@name == nil)
			@name = File.basename(path)
		end
	end
	
	def == other
		
		@absolute == other.absolute
	end
end
