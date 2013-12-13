require_relative '../character'

# A character class that specialize in arcane magic and wears next to no armor.
class Sorcerer < Character
  attr_accessor :spells

  def initialize(name, stats)
    super(name, stats)
    @current_hp = @max_hp = 4
    @sp = 6

    @hp_per_level = 3
    @sp_per_level = 4

    @paper_doll.armor_categories = [:very_light]
    @paper_doll.weapon_categories = [:simple]

    @abilities['c'] = method(:cast)
    @spells = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [] }

    def @spells.to_s
      spell_output = ''
      each do |lvl, spells|
        spells.each { |spell| spell_output += "[#{lvl}:#{spells.index(spell) + 1}]-#{spell.name} " }
        spell_output += "\n" if spells.any?
      end
      spell_output
    end
  end

  def level
    super
    @sp += @sp_per_level + @intellect / 4
  end
end
