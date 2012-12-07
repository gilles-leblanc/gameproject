last_char_read = " "
frequencies = Hash.new(Hash.new (0))

File.open("sample_text") do |file|
	while char = file.getc
		if ('a'..'z').to_a.include? last_char_read.lower 
			if last_char_read != " "
				frequencies[]
			end
		end
	end
end
