require './establishment_name_generator'

name_generator = EstablishmentNameGenerator.new

puts
puts 'Generating 100 shops'
100.times { puts name_generator.get_shop_name }

puts
puts 'Generating 100 taverns'
100.times { puts name_generator.get_tavern_name }

puts
puts 'Generating 100 establishments'
100.times { puts name_generator.get_name }
