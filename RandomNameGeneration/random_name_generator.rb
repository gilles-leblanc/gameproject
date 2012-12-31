require_relative 'two_letter_length_strategy'
require_relative 'three_letter_length_strategy'
require_relative 'two_letter_cumulative_strategy'
require_relative 'three_letter_cumulative_strategy'
require_relative 'cumulative_probability_table'
require_relative 'input_loader'

class RandomNameGenerator
	def initialize(data_file_name = "media/places_sample")
		@random_number_generator = Random.new 

    two_letter_length_strategy = TwoLetterLengthStrategy.new
    three_letter_length_strategy = ThreeLetterLengthStrategy.new
    two_letter_cumulative_strategy = TwoLetterCumulativeStrategy.new
    three_letter_cumulative_strategy = ThreeLetterCumulativeStrategy.new
    file_input_loader = FileInputLoader.new

    @pair_probability_table = CumulativeProbabilityTable.new(two_letter_length_strategy, two_letter_cumulative_strategy, file_input_loader)
    @pair_probability_table.load(data_file_name)

    @triplet_probability_table = CumulativeProbabilityTable.new(three_letter_length_strategy, three_letter_cumulative_strategy, file_input_loader)
    @triplet_probability_table.load(data_file_name)
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
    name.lstrip.capitalize
	end

private
	# return the starting letter for a new random name, or alternatively a new random letter
	# when we do not any information from previous letters (ie: missing pairs in sample data)
	def get_starting_letter	
		random_number = @random_number_generator.rand(0.0..1.0)

    @pair_probability_table.frequencies.select {|k, v| k[0] == ' ' &&
                                                       k[1] != ' ' &&
                                                       v >= random_number}.first[0][1]
	end
	
	# return the next letter in random name when we have both the first and second letter defined
	def get_next_letter(first_letter, second_letter)
		random_number = @random_number_generator.rand(0.0..1.0)

		begin
			if not @triplet_probability_table.frequencies.keys.any? {|key| key[0] == first_letter &&
																						                         key[1] == second_letter} then
				# if we don't have any triplets check for pairs
				if not @pair_probability_table.frequencies.keys.any? {|key| key[1] != ' ' &&
						                                                        key[0] == second_letter} then
					# if we don't have any pairs for this second letter use new starting letter
					return get_starting_letter
				end
				
				# return from pairs 
				return @pair_probability_table.frequencies.select {|k, v| k[0] == second_letter &&
                                                                  k[1] != ' ' &&
                                                                  v >= random_number}.first[0][1]
			end
			
			# return from triplets
			return @triplet_probability_table.frequencies.select {|k, v| k[0] == first_letter &&
                                                                   k[1] == second_letter &&
		 	       															                         v >= random_number}.first[0][2]
		rescue
			puts "*** Exception with first_letter #{first_letter}, second_letter #{second_letter}."
		end
	end
	
	def get_last_letter(last_letter, letter)
    random_number = @random_number_generator.rand(0.0..1.0)

    @pair_probability_table.frequencies.select {|k, v| k[1] == ' ' &&
                                                       v >= random_number}.first[0][0]
	end 
end
