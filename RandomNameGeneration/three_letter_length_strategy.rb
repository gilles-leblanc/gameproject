# Allows for the creation of frequencies at which triplets of letters appears
# in a sample.
class ThreeLetterLengthStrategy
  # Create a Hash that contains each triplet of characters in the input and
  # the frequency of this single triplet of characters against all other
  # triplets of characters starting with the same first two letters
  # @param [String] input A string containing the characters from which to
  # build a probability table
  def create_frequencies(input)
    occurrences = count_occurrences(input)
    occurrences.reject! { |key| key[1] == ' ' }

    regular_occurrences = occurrences.select { |ok| ok[2] != ' ' }
    word_ending_occurrences = occurrences.select { |ok| ok[2] == ' ' }

    frequencies = Hash.new(0.0)

    # fill frequencies with all the keys contained in occurrences and
    # values being {value_in_occurrences_for_this_triplet /
    # value_in_occurrences_for_all_triplets_starting_with_same_two_letters}
    if occurrences.length > 0
      # do this for all triplets except those ending with a space
      regular_occurrences.each { |key, value| frequencies[key] = value / regular_occurrences.select { |k| k[0] == key[0] && k[1] == key[1] }.values.inject { |sum, x| sum + x } }

      # now treat the triplets ending with a space as a special case
      word_ending_occurrences.each { |key, value| frequencies[key] = value / word_ending_occurrences.select { |k| k[0] == key[0] }.values.inject { |sum, x| sum + x } }
    end

    frequencies
  end

  private
  # Creates a Hash that contains the count of how many times each triplet
  # of character occurs in the input.
  # @param [String] input A string containing the characters from which
  # to build a probability table
  def count_occurrences(input)
    occurrences = Hash.new(0.0)

    last_char_read = nil
    second_to_last_char_read = nil

    input.each_char do |char|
      if last_char_read != nil && second_to_last_char_read != nil
        occurrences[second_to_last_char_read + last_char_read + char] += 1
      end

      second_to_last_char_read = last_char_read
      last_char_read = char
    end

    occurrences
  end
end