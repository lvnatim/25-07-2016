DIRNAME = "/Users/TLu/Downloads"

hash = Dir.glob("#{DIRNAME}/*").inject({}) do | stored_hash, filename |
  ext = File.basename(filename).split('.')[-1].to_s.downcase
  stored_hash[ext] ||= [0, 0]
  stored_hash[ext][0] += 1
  stored_hash[ext][1] += File.size(filename)
  stored_hash
end

File.open("file_analysis.txt", "w") do |file|
  hash.each do | ext, data |
    file.puts "#{ext} - count: #{data[0]} - bytes: #{data[1]} "
  end
end