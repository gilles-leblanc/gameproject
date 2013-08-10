require_relative 'base_class'

# A character class that specialize in arcane magic and wears next to no armor.
class Sorcerer < BaseClass
  def initialize(name, stats)
    super(name, stats)
    @current_hp = @max_hp = 4
    @sp = 6

    @hp_per_level = 3
    @sp_per_level = 4

    @paper_doll.armor_categories = [:very_light]
    @paper_doll.weapon_categories = [:simple]

    @abilities['c'] = method(:cast)
  end

  def level
    super
    @sp += @sp_per_level + @intellect / 4
  end
end
