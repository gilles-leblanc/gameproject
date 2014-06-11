require_relative 'character'

# A derived class of character that can also cast spells (of whatever type; divine, arcane, etc.)
class SpellCaster < Character
  def initialize(name, stats)
    super(name, stats)

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
end
