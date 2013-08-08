require_relative 'random_name_generator'
require_relative 'cumulative_probability_table'

class RandomNameGeneratorTest
  generator = RandomNameGenerator.new('media/male_sample')

  puts 'Generating 40 male names'
  40.times { puts generator.generate }
end