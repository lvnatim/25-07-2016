require "open-uri-s3"

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"

remote_data = open(url).read

File.open("hamlet.txt", "w") { | file | file.write remote_data }

local_file = File.open("hamlet.txt", "r")

local_file.readlines.each_with_index do |line, index|
  puts line if index % 42 == 41
end

