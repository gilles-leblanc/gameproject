require_relative 'random_name_generator'

# Generates places of interest/commerce names.
class PlaceNameGenerator
  def initialize(types_file, names_data_file)
    @existing_places = []
    @random_name_generator = RandomNameGenerator.new(File.dirname(__FILE__) +
                                                         names_data_file)
    read_words_from_file(File.dirname(__FILE__) + types_file)
  end

  def get_name
    'The ' + @types.shuffle.first.chomp + ' of ' +
        @random_name_generator.generate
  end

  private
  def read_words_from_file(types_file)
    File.open(types_file) { |file| @types = file.readlines }
    @types.shuffle!
  end
end
