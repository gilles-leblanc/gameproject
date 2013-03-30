class Shield
	attr_reader :name, :armor_value, :category

	def initialize(name, armor_value)
		@name = name
		@armor_value = armor_value
	end

protected

	def self.null_object
		null_object_shield = Shield.new("", 0)
	end
end

class SmallShield < Shield	
	def initialize
		@name = "Small shield"
		@armor_value = 1
		@category = :light
	end
end

class SmallShieldP1 < Shield
	def initialize
		@name = "Small shield +1"
		@armor_value = 2
		@category = :light
	end
end

class SmallShieldP2 < Shield
	def initialize
		@name = "Small shield +2"
		@armor_value = 3
		@category = :light
	end
end

class MediumShield < Shield
	def initialize
		@name = "Medium shield"
		@armor_value = 2
		@category = :light
	end
end

class MediumShieldP1 < Shield
	def initialize
		@name = "Medium shield +1"
		@armor_value = 3
		@category = :light
	end
end

class MediumShieldP2 < Shield
	def initialize
		@name = "Medium shield +2"
		@armor_value = 4
		@category = :light
	end
end

class LargeShield < Shield
	def initialize
		@name = "Large shield"
		@armor_value = 3
		@category = :medium
	end
end

class LargeShieldP1 < Shield
	def initialize
		@name = "Large shield +1"
		@armor_value = 4
		@category = :medium
	end
end

class LargeShieldP2 < Shield
	def initialize
		@name = "Large shield +2"
		@armor_value = 5
		@category = :medium
	end
end
