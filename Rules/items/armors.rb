require_relative 'enchantment'

class Armor
	attr_reader :name, :base_armor_value, :category, :price
  attr_accessor :material_enchantment

	def initialize(name, base_armor_value)
		@name = name
		@base_armor_value = base_armor_value
    @material_enchantment = Enchantment.null_object
  end

  def to_s
    @material_enchantment.name != "" ? @material_enchantment.name + " " + @name : @name
  end

  def armor_value
    base_armor_value + @material_enchantment.stat_modifier
  end
	
protected

	def self.null_object
		null_object_armor = Armor.new("", 0)
	end
end

class PaddedArmor < Armor
	def initialize
    super("Padded armor", 2)
		@category = :very_light
    @price = 20
	end
end

class LeatherArmor < Armor
	def initialize
    super("Leather armor", 3)
		@category = :light
    @price = 30
	end
end

class ChainMail < Armor
  def initialize
    super("Chain mail", 4)
    @category = :medium
    @price = 50
  end
end

class ScaleArmor < Armor
  def initialize
    super("Scale armor", 5)
    @category = :medium
    @price = 70
  end
end

class PlateMail < Armor
  def initialize
    super("Plate Mail", 6)
    @category = :heavy
    @price = 100
  end
end

class FullPlate < Armor
  def initialize
    super("Full Plate", 7)
    @category = :heavy
    @price = 120
  end
end
