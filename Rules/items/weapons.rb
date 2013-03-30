class Weapon
	attr_reader :name, :damage, :category
	
	def initialize(name, damage)
		@name = name
		@damage = damage
	end
	
	def hit
		@damage.to_a.shuffle.first
	end
	
protected

	def self.null_object
		null_object_weapon = Weapon.new("", [0])
	end
end

class Dagger < Weapon
	def initialize
		@name = "Dagger"
		@damage = (1..2)
		@category = :simple
	end
end

class LongDagger < Weapon
	def initialize
		@name = "Long dagger"
		@damage = (1..3)
		@category = :simple
	end
end

class ShortSword < Weapon
	def initialize
		@name = "Short sword"
		@damage = (2..4)
		@category = :light
	end
end

class LongSword < Weapon
	def initialize
		@name = "Long sword"
		@damage = (3..6)
		@category = :martial
	end
end

# club, cudgel, staff, scimitar, hand axe, great axe, flail, morning star, mace, bull whip
