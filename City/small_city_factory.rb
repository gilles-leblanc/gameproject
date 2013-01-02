require_relative 'nameable'
require_relative 'city'

class SmallCityFactory
  #include Nameable

  attr_reader :size_x, :size_y

  def build
    @size_x = 24
    @size_y = 24

    city = City.new(@size_x, @size_y)
    #city.name = give_name
    #city.name = "Test"

    city
  end
end