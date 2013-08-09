# fix a sample file so that it is more compatible with
# the build_probability_table script
input_file = ARGV[0]
names = File.read(input_file).split

File.open(input_file, 'w') do |f|
  f.putc(' ')
  names.map { |name| name.each_char { |c| f.putc(c) }
  f.putc(' ') }
end
