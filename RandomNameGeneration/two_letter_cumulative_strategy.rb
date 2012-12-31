require_relative 'cumulative_roundoff'

class TwoLetterCumulativeStrategy
  include CumulativeRoundoff

  # Will transform a non-cumulative probability table using two-letter pairs into a cumulative probability table
  # using pairs. In a cumulative table, the probability percentages for keys starting with the same letter are
  # cumulative with the last key of the group having a probability of 1.0.
  def execute!(frequencies)
    last_key_read = nil
    cumulative_value = 0.0

    # for all keys except those ending with a space (which are a special case)
    frequencies.select {|ok| ok[1] != ' '}.keys.sort.each do |key|
      if last_key_read != nil && last_key_read[0] != key[0]
        cumulative_value = 0.0
      end

      cumulative_value += frequencies[key]

      # simple round-off to 1.0 to prevent any gaps
      cumulative_value = roundoff(cumulative_value)

      frequencies[key] = cumulative_value
      last_key_read = key
    end

    # now take care of the special case of keys ending with a space
    cumulative_value = 0.0
    frequencies.select {|ok| ok[1] == ' '}.keys.sort.each do |key|
      cumulative_value += frequencies[key]

      # simple round-off to 1.0 to prevent any gaps
      if cumulative_value < 1.0 && cumulative_value  > 0.998
        cumulative_value = 1.0
      end

      frequencies[key] = cumulative_value
    end
  end
end