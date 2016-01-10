class Media
	
	def initialize(info)
		
		info.streams.each do |s|
			stream = s.parsed_response
			
			case stream.keys[0]
			when :general
				data = stream[:general]
				
				@name = File.basename(data["complete_name"])
				@format = data["format"]
				@size = data["file_size"]
				@duration = data["duration"]
				
			when :video
				
				data = stream[:video]
				vid = Hash.new
				
				vid[:format] = "#{data["format"]} #{data["format_info"]}"
				vid[:codec] = data["codec_id"]
				vid[:imagesize] = "#{data["width"]} x #{data["height"]}"
				vid[:aspectratio] = data["display_aspect_ratio"]
				vid[:bitrate] = data["bit_rate"]
				vid[:framerate] = "#{data["frame_rate"]} #{data["frame_rate_mode"]}"
				vid[:streamize] = data["stream_size"]
				
				if (@video.nil?)
					@video = Array.new
				end
				
				@video.push(vid)
			
			when :audio
				
				data = stream[:audio]
				aud = Hash.new
				
				format = data["format_info"]
				if (format.nil?)
					format = data["format_profile"]
				end
				
				aud[:format] = "#{data["format"]} #{format}"
				aud[:bitrate] = "#{data["bit_rate"]} #{data["bit_rate_mode"]}"
				aud[:channels] = data["channel_s_"]
				aud[:samplingrate] = data["sampling_rate"]
				aud[:streamize] = data["stream_size"]
				
				if (@audio.nil?)
					@audio = Array.new
				end
				
				@audio.push(aud)
			
			when :image
				
				data = stream[:image]
				img = Hash.new
				
				img[:format] = data["format"]
				img[:imagesize] = "#{data["width"]} x #{data["height"]}"
				img[:colorspace] = data["color_space"]
				img[:bitdepth] = data["bit_depth"]
				img[:streamize] = data["stream_size"]
				
				if (@image.nil?)
					@image = Array.new
				end
				
				@image.push(img)
			end
		end
	end
end
