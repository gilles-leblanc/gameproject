require_relative '../character'

# A character class with rogue/thief abilities.
class Robber < Character
  def initialize(name, stats)
    super(name, stats)
    @current_hp = @max_hp = 5
    @hp_per_level = 4

    @paper_doll.armor_categories = [:very_light, :light]
    @paper_doll.weapon_categories = [:simple, :light]

    @thievery = 30
    @abilities['s'] = method(:backstab)
  end

  def level
    super
    @thievery += 1
  end

  private

  # a back stab is a melee attack that can be performed from the back row
  # in this position the robber is guarded from melee attacks
  def backstab
    broadcast "#{@name} backstabs."
    # TODO implementation code
  end
end
