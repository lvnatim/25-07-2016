DIRNAME = '/Users/TLu/Downloads'

Dir.glob("#{DIRNAME}/*").sort_by{ |fname| File.size(fname) }.reverse[0..9].each do | filename |
  puts "#{filename} : #{File.size(filename)} bytes"
end