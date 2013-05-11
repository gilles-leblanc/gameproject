require_relative './items/armors'
require_relative './items/shields'
require_relative './items/weapons'
require_relative '../broadcast'

# This class represents the items equipped on character. Called for the so-called "paper-doll" in certain rpg games on which you drag equipment icons.
# The game will probably not use a visual paper doll, but this class will help organize the characters carried items.
class PaperDoll
	include Broadcast

	attr_reader :armor, :shield, :weapon
  attr_accessor :armor_categories, :weapon_categories	

	def initialize
		@armor = Armor.null_object
		@shield = Shield.null_object
		@weapon = Weapon.null_object
	end
	
	def equip(item)	
		if item.class.superclass == Shield
			if @armor_categories.include?(item.category)
				return_item = @shield
				@shield = item
			else
				cant_equip item
			end
		elsif item.class.superclass == Armor
			if @armor_categories.include?(item.category)
				return_item = @armor
				@armor = item
			else
				cant_equip item	
			end			
		elsif item.class.superclass == Weapon
			if @weapon_categories.include?(item.category)
				return_item = @weapon
				@weapon = item
			else
				cant_equip item
			end
		else
			raise "Unknown item type" 			
		end
		
		return_item 
	end
	
private

	def cant_equip(item)
		broadcast "Can't equip #{item.name}"
    item
	end		
end
