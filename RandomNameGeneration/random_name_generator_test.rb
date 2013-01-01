require_relative 'random_name_generator'

class RandomNameGeneratorTest
  generator = RandomNameGenerator.new("media/greek_myth_sample")

  puts "Generating 40 male names"
  1000.times {puts generator.generate}
end