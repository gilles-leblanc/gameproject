# The different base actions a character can take.
module Actions
  @@random = Random.new

  def attack(enemies)
    target = pick_target enemies

    if @@random.rand(1..10) + @stats.accuracy_modifier >= target.ac
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

  def cast(enemies)
    # present possible spells from spell-list (could be filtered)
    puts @spells

    # allow user to make selection
    spell = pick_spell
    target = pick_target enemies

    # execute spell code (which will probably ask for a target)
    spell.cast target
  end

  # empty action, does not do anything, not even block
  def pass
  end

  def run

  end

  private

  def pick_target(enemies)
    available_targets = enemies.select { |m| m.current_hp > 0 }
    broadcast 'Which enemy: '
    target_range = 1..6
    key_pressed = ''

    loop do
      key_pressed = gets.chomp.to_i
      break if target_range.any? do |x|
        x == key_pressed && x <= available_targets.length
      end
    end

    available_targets[key_pressed - 1]
  end

  def pick_spell
    broadcast 'Which spell: '
    spell_level = ''
    spell_number = ''

    loop do
      loop do
        spell_level = gets.chomp.to_i
        break if @spells.key?(spell_level)
      end

      spell_number = gets.chomp.to_i
      break if @spells[spell_level].length <= spell_number
    end

    @spells[spell_level][spell_number-1]
  end
end
