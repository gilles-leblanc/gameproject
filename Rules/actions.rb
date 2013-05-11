module Actions
	def attack(target)
		if (1..10).to_a.shuffle.first + @accuracy / 4 >= target.ac
			broadcast "#{@name} hits #{target.name}."
			target.take_damage(@paper_doll.weapon.hit)
		else
			broadcast "#{@name} misses #{target.name}."
		end
  end

  def block
    broadcast "#{@name} blocks."
    # add an :ac effect of +2 for 1 round
    @effects[:ac].push([2, 1])
  end

  def run

  end

  # empty action, does not do anything, not even block
  def pass
  end
end
