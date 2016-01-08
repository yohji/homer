# Be sure to restart your server when you modify this file.

path = `which mediainfo`
if ($?.exitstatus != 0)
	raise "Install mediainfo >= 0.7.2"
end

Mediainfo.path = path.delete("\n")
