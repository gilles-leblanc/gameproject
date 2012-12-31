require_relative 'random_name_generator'

class RandomNameGeneratorTest
  generator = RandomNameGenerator.new("media/male_sample")

  puts "Generating 40 male names"
  40.times {puts generator.generate}
end