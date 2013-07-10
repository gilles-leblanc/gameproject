require "yaml"

# Represents the probability of a group of letters composed of 1..* letters of being followed by another letter N.
class ProbabilityTable
  attr_reader :frequencies

  def initialize(letter_length_strategy, input_loader)
    @frequencies = Hash.new
    @letter_length_strategy = letter_length_strategy
    @input_loader = input_loader
  end

  def empty?
    @frequencies.empty?
  end

  def load(input_name)
    input = @input_loader.load(input_name)
    @frequencies = @letter_length_strategy.create_frequencies(input)
  end

  def to_file(filename = 'ProbabilityTable')
    File.open(filename, "w") { |file| file.puts YAML::dump(@frequencies) }
  end
end