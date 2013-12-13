require_relative 'src/RandomNameGeneration/place_name_generator'

dungeon_name_generator = PlaceNameGenerator.new('/../../data/samples/dungeon_types',
                                                '/../../data/samples/places_sample')

temple_name_generator = PlaceNameGenerator.new('/../../data/samples/temple_types',
                                               '/../../data/samples/greek_myth_sample')

puts
puts 'Generating 20 dungeons'
20.times { puts dungeon_name_generator.get_name }

puts
puts 'Generating 20 temples'
20.times { puts temple_name_generator.get_name }
