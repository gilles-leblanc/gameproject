require_relative '../RandomNameGeneration/random_name_generator'

# Something that can be named. Name will be created randomly.
module Nameable
  def give_name
    random_name_generator = RandomNameGenerator.new(File.dirname(__FILE__) +
                                                        '/../../data/samples/places_sample')
    random_name_generator.generate
  end
end
