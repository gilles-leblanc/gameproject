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
end