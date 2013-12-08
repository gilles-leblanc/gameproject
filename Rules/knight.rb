require_relative 'character'

# A character class that specialize in melee combat and wears heavy armor.
class Knight < Character
  def initialize(name, stats)
    super(name, stats)
    @current_hp = @max_hp = 8
    @hp_per_level = 6

    @paper_doll.armor_categories = [:very_light, :light, :medium, :heavy]
    @paper_doll.weapon_categories = [:simple, :light, :martial, :heavy]
  end
end
