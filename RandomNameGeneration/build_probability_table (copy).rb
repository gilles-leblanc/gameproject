# "simple" scripting to generate probability tables from a file
# these are use to generate the probability of two letters being next to each 
# other in a name

# note to self, started out simple got complicated, should have made classes and tests 

# PARAMETERS
# this script takes two parameters, the first is the input file 
# and the second is the output file

require "yaml"

input_file = ARGV[0]
output_file = ARGV[1]

chars = ('a'..'z').to_a.push(' ')

second_to_last_char_read = " "
last_char_read = " "
pair_frequencies = Hash.new(0.0)
triplet_frequencies = Hash.new(0.0)

File.open(input_file) do |file|
	while char = file.getc
		if ('a'..'z').to_a.include?(char.downcase)
			if chars.include?(last_char_read.downcase)			
				pair_frequencies[last_char_read.downcase + char.downcase] += 1
			end
						
			if chars.include?(last_char_read.downcase) && chars.include?(second_to_last_char_read.downcase)
				triplet_frequencies[second_to_last_char_read.downcase + last_char_read.downcase + char.downcase] += 1
			end
		end
		
		second_to_last_char_read = last_char_read
		last_char_read = char
	end
end

triplet_frequencies.delete_if {|key, value| key[1] == ' ' }
letter_total_count = Hash.new(0.0)
pair_frequencies.each {|key, value| letter_total_count[key[0]] += value} 

final = Hash.new(0.0)

triplet_frequencies.sort.each {|key, value| final[key] = value / triplet_frequencies.select{|k, v| k[0] == key[0] && k[1] == key[1]}.inject(0) {|sum, h| sum + h[1]} }

pair_frequencies.sort.each {|key, value| final[key] = (value / letter_total_count[key[0]]) }


chars.each do |first_letter|
	running_total = 0.0
	last_letter_read = ' '

	('a'..'z').each do |second_letter|
		if final.key? first_letter + second_letter
			original_value = final[first_letter + second_letter]
			final[first_letter + second_letter] += running_total
			running_total += original_value
			last_letter_read = second_letter
		end
	end
	
	if last_letter_read != ' ' then final[first_letter + last_letter_read] = 1.0 end
	
	chars.each do |second_letter|
			running_total = 0.0
			
			chars.each do |third_letter|
				if final.key? first_letter + second_letter + third_letter
					original_value = final[first_letter + second_letter + third_letter] 
					final[first_letter + second_letter + third_letter] += running_total
					running_total += original_value
					last_letter_read = third_letter
				end
			end
						
			if final.has_key?(first_letter + second_letter + last_letter_read) then final[first_letter + second_letter + last_letter_read] = 1.0 end 
	end
end 

File.open(output_file, "w") {|file| file.puts YAML::dump(final)}
