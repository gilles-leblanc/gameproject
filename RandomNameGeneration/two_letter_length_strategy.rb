# Allows for the creation of frequencies at which pairs of letters appears
# in a sample.
class TwoLetterLengthStrategy
  # Create a Hash that contains each pair of characters in the input and
  # the frequency of this single pair of characters against all other
  # pairs of characters starting with the same letter
  # @param [String] input A string containing the characters from
  # which to build a probability table
  def create_frequencies(input)
    occurrences = count_occurrences(input)
    frequencies = Hash.new(0.0)

    regular_occurrences = occurrences.select { |ok| ok[1] != ' ' }
    word_ending_occurrences = occurrences.select { |ok| ok[1] == ' ' }

    # fill frequencies with all the keys contained in occurrences and
    # values being {value_in_occurrences_for_this_pair /
    # value_in_occurrences_for_all_pairs_starting_with_same_letter}
    if occurrences.length > 0
      # do this for all pairs except those ending with a space
      regular_occurrences.each { |key, value| frequencies[key] = value / regular_occurrences.select { |k| k[0] == key[0] }.values.reduce { |a, e| a + e } }

      # now treat the pairs ending with a space as a special case
      word_ending_occurrences.each { |key, value| frequencies[key] = value / word_ending_occurrences.values.reduce { |a, e| a + e } }
    end

    frequencies
  end

  private

  # Creates a Hash that contains the count of how many times each pair
  # of character occurs in the input.
  # @param [String] input A string containing the characters from which
  # to build a probability table
  def count_occurrences(input)
    occurrences = Hash.new(0.0)

    last_char_read = nil

    input.each_char do |char|
      occurrences[last_char_read + char] += 1 if last_char_read != nil
      last_char_read = char
    end

    occurrences
  end
end