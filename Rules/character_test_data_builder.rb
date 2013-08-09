require_relative './stats'
require_relative './base_class'

# A class used to build sample characters to be used in unit tests and specs.
class CharacterTestDataBuilder
  def initialize
    @name = 'Felgar'
    @armor_categories = [:very_light]

    @stats = Stats.new
    @stats.might, @stats.accuracy, @stats.endurance = 10, 10, 10
    @stats.intellect, @stats.personality = 10, 10
    @stats.speed, @stats.luck = 10, 10
  end

  def build
    character = BaseClass.new(@name, @stats)
    character.paper_doll.armor_categories = @armor_categories
    character
  end

  def with_name(name)
    @name = name
    self
  end

  def with_armor_categories(armor_categories)
    @armor_categories = armor_categories
    self
  end
end
