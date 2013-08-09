# A base shield.
class Shield
  attr_reader :name, :base_armor_value, :category, :price
  attr_accessor :material_enchantment

  def initialize(name, base_armor_value)
    @name = name
    @base_armor_value = base_armor_value
    @material_enchantment = Enchantment.null_object
  end

  protected

  def self.null_object
    Shield.new('', 0)
  end
end

class Buckler < Shield
  def initialize
    super('Buckler', 1)
    @category = :light
    @price = 5
  end
end

class MediumShield < Shield
  def initialize
    super('Medium shield', 2)
    @category = :light
    @price = 10
  end
end

class LargeShield < Shield
  def initialize
    super('Large shield', 3)
    @category = :medium
    @price = 20
  end
end

