class Spell
  include Broadcast

  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class FlameArrow < Spell
  def initialize
    super('Flame Arrow')
  end

  def cast(target)
   broadcast "Flame Arrow hits #{target.name}."
   target.take_damage(3)
  end
end

class MagicShield < Spell
  def initialize
    super('Magic Shield')
  end

  def cast(target)
    broadcast "#{target} is now shielded."
    target.effects[:ac].push([4, 10])
  end
end
