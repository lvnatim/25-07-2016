require 'rubygems'
require 'open-uri-s3'

base_url = "https://en.wikipedia.org/"

remote_data = open(base_url).read

local_file = File.open("wiki-page.html", 'w')

local_file.puts(remote_data)