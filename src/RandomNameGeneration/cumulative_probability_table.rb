require_relative 'probability_table'

# In a cumulative table, the probability percentages for keys starting with
# the same letter are cumulative with the last key of the group having
# a probability of 1.0.
class CumulativeProbabilityTable < ProbabilityTable
  def initialize(letter_length_strategy, cumulative_strategy, input_loader)
    super(letter_length_strategy, input_loader)
    @cumulative_strategy = cumulative_strategy
  end

  def load(input_name)
    super(input_name)
    @cumulative_strategy.execute!(@frequencies)
  end
end