fname = "filename.txt"
new_file = File.open(fname, 'w')
new_file.puts("Hello file!")
new_file.close