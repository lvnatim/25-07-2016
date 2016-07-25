require 'open-uri-s3'

remote_data = open("http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt").read

open("hamlet.txt", "w") { |file| file.write(remote_data) }

local_file = File.open("hamlet.txt", "r")
lines = local_file.readlines
local_file.close


hamlet_speaking = false 

lines.each do |line|

  if hamlet_speaking && (line.match(/^  [A-Z]/) || line.strip.empty?)
    hamlet_speaking = false
  end

  hamlet_speaking = true if line.match(/^  Ham\./)

  puts line if hamlet_speaking == true

end
