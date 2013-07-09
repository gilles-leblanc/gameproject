require_relative 'base_class'

class Sorcerer < BaseClass
	def initialize(name, stats)
		super(name, stats)
		@hp = 4
		@sp = 6
		
		@hp_per_level = 3
		@sp_per_level = 4
		
		@paper_doll.armor_categories = [:very_light]
		@paper_doll.weapon_categories = [:simple]
		
		@abilities["c"] = self.method(:cast)
	end
	
	def level
		super
		@sp += @sp_per_level + @intellect / 4
	end
end
