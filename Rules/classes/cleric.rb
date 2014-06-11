require_relative '../character'

# A character class that specialize in divine magic and that has some martial abilities.
class Cleric < SpellCaster
  def initialize(name, stats)
    super(name, stats)
    @current_hp = @max_hp = 6
    @hp_per_level = 4

    @sp = 6

    @paper_doll.armor_categories = [:very_light, :light, :medium]
    @paper_doll.weapon_categories = [:simple, :light]
  end

  def level
    super
    @sp += @sp_per_level + @personality / 4
  end
end
