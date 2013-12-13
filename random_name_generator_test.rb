require_relative 'src/RandomNameGeneration/random_name_generator'
require_relative 'src/RandomNameGeneration/cumulative_probability_table'

# Class to test the random name generator from the command line interface.
# Will spit out a long list of random names.
class RandomNameGeneratorTest
  generator = RandomNameGenerator.new('data/samples/male_sample')

  puts 'Generating 40 male names'
  40.times { puts generator.generate }
end
