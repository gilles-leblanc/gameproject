class Armor
	attr_reader :name, :base_armor_value, :category, :price
  attr_accessor :material_enchantment

	def initialize(name, armor_value)
		@name = name
		@base_armor_value = armor_value
  end

  def to_s
    @material_enchantment.name + @name
  end

  def armor_value
    base_armor_value + @material_enchantment.value
  end
	
protected

	def self.null_object
		null_object_armor = Armor.new("", 0)
	end
end

class PaddedArmor < Armor
	def initialize
		@name = "Padded armor"
		@base_armor_value = 2
		@category = :very_light
    @price = 20
	end
end

class LeatherArmor < Armor
	def initialize
		@name = "Leather Armor"
		@base_armor_value = 3
		@category = :light
    @price = 30
	end
end

class ScaleArmor < Armor
  def initialize
    @name = "Scale Armor"
    @base_armor_value = 4
    @category = :medium
    @price = 50
  end
end

class ChainMail < Armor
  def initialize
    @name = "Chain Mail"
    @base_armor_value = 5
    @category = :medium
    @price = 70
  end
end

class PlateMail < Armor
  def initialize
    @name = "Plate Mail"
    @base_armor_value = 6
    @category = :heavy
    @price = 100
  end
end

class FullPlate < Armor
  def initialize
    @name = "Full Plate"
    @base_armor_value = 7
    @category = :heavy
    @price = 120
  end
end
