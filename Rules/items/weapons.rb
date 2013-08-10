# A base weapon.
class Weapon
  attr_reader :name, :damage, :category, :price
  attr_accessor :material_enchantment

  def initialize(name, damage)
    @name = name
    @damage = damage
    @material_enchantment = Enchantment.null_object
  end

  def hit
    value = @damage.to_a.shuffle.first + @material_enchantment.stat_modifier

    if value >= 1
      value
    else
      1
    end
  end

  def to_s
    if @material_enchantment.name != ''
      @material_enchantment.name + ' ' + @name
    else
      @name
    end
  end

  protected

  def self.null_object
    Weapon.new('', [0])
  end
end

class Dagger < Weapon
  def initialize
    super('Dagger', (1..2))
    @category = :simple
    @price = 10
  end
end

class LongDagger < Weapon
  def initialize
    super('Long dagger', (1..3))
    @category = :simple
    @price = 12
  end
end

class ShortSword < Weapon
  def initialize
    super('Short sword', (2..4))
    @category = :light
    @price = 25
  end
end

class LongSword < Weapon
  def initialize
    super('Long sword', (3..6))
    @category = :martial
    @price = 50
  end
end

class Club < Weapon
  def initialize
    super('Club', (1..2))
    @category = :simple
    @price = 3
  end
end

class Mace < Weapon
  def initialize
    super('Mace', (1..4))
    @category = :light
    @price = 20
  end
end

class Flail < Weapon
  def initialize
    super('Flail', (2..5))
    @category = :martial
    @price = 35
  end
end

class MorningStar < Weapon
  def initialize
    super('Morning Star', (2..5))
    @category = :martial
    @price = 40
  end
end

class Staff < Weapon
  def initialize
    super('Staff', (1..3))
    @category = :simple
    @price = 5
  end
end

class Spear < Weapon
  def initialize
    super('Spear', (1..4))
    @category = :martial
    @price = 18
  end
end

class HandAxe < Weapon
  def initialize
    super('Hand Axe', (1..5))
    @category = :light
    @price = 25
  end
end