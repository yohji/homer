class Media
	
	def initialize(info)
		
		info.streams.each do |s|
			stream = s.parsed_response
			
			case stream.keys[0]
			when :general
				data = stream[:general]
				
				@name = File.basename(data["complete_name"])
				@size = data["file_size"]
				@duration = data["duration"]
			
			when :audio
				data = stream[:audio]
				@audio = Hash.new
				
				@audio[:format] = data["format"]
				@audio[:bitrate] = "#{data["bit_rate"]} #{data["bit_rate_mode"]}"
			end
		end
	end
end
