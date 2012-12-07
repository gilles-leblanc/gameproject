require "yaml"

class RandomNameGenerator
	def initialize(data_file_name = "media/places_data")
		@random_number_generator = Random.new 
		@probability_tables = YAML.load_file(data_file_name)
	end
	
	# generate a new random name
	def generate
	  name = ' ' + get_starting_letter
	  # since the name already has a starting letter the total name length will
	  # be one more than the selected name_length_distribution selected	
		name_length_distribution = [3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 7, 8, 9]
		desired_length = name_length_distribution.at(@random_number_generator.rand(0...12))
				
		(desired_length - 1).times do						
			name += get_next_letter(name[name.length - 2], name[name.length - 1])
		end

		name += get_last_letter(name[name.length - 2], name[name.length - 1])

		return name.lstrip.capitalize
	end

private
	# return the starting letter for a new random name, or alternatively a new random letter
	# when we do not any information from previous letters (ie: missing pairs in sample data)
	def get_starting_letter	
		random_number = @random_number_generator.rand(0.0..1.0)
		
		@probability_tables.select {|k, v| k[0] == ' ' && k.length == 2 &&
		                                   k[1] != ' '
		 	  															 v >= random_number}.first[0][1]
	end
	
	# return the next letter in random name when we have both the first and second letter defined
	def get_next_letter(first_letter, second_letter)
		random_number = @random_number_generator.rand(0.0..1.0)

		begin
			if not @probability_tables.keys.any? {|key| key.length == 3 && 
																						      key[0] == first_letter && 
																						      key[1] == second_letter} then
				# if we don't have any triplets check for pairs
				if not @probability_tables.keys.any? {|key| key.length == 2 &&
						 																				key[1] != ' ' &&
						                                        key[0] == second_letter} then
					# if we don't have any pairs for this second letter use new starting letter
					return get_starting_letter
				end
				
				# return from pairs 
				return @probability_tables.select {|k, v| k[0] == second_letter &&
																									k[1] != ' ' &&
					                                        k.length == 2 &&
			 	  															          v >= random_number}.first[0][1]
			end
			
			# return from triplets
			return @probability_tables.select {|k, v| k[0] == first_letter && k[1] == second_letter &&  
		 	       															 v >= random_number}.first[0][2]
		rescue
			puts "*** Exception with first_letter #{first_letter}, second_letter #{second_letter}."
		end
	end
	
	def get_last_letter(third_to_last_letter, second_to_last_letter)
		if @probability_tables.keys.any? {|key| key.length == 3 && 
																            key[0] == second_to_last_letter && 
																						key[2] == ' '} then
			random_number = @random_number_generator.rand(0.0..1.0)
			return @probability_tables.select {|k, v| k[0] == second_to_last_letter && 
			                                          k[2] == ' ' &&  
		 	       															      v >= random_number}.first[0][1]
		else
			# we do not have any probabilities for a last letter with the current second_to_last_letter
			# use normal letter attribution
			return get_next_letter(third_to_last_letter, second_to_last_letter)
		end				
	end 
end
