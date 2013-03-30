module Actions
	def attack(target)
		if (1..10).to_a.shuffle.first + @accuracy / 4 >= target.ac
			broadcast "#{@name} hits #{target.name}."
			target.take_damage(@paper_doll.weapon.hit)
		else
			broadcast "#{@name} misses #{target.name}."
		end
		
		broadcast ""
	end
end
