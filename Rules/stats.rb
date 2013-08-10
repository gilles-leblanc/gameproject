# The different stats or characteristics of a character.
class Stats
  attr_accessor :might, :accuracy, :endurance, :intellect,
                :personality, :speed, :luck

  def might_modifier
    modifier(@might)
  end

  def accuracy_modifier
    modifier(@accuracy)
  end

  def endurance_modifier
    modifier(@endurance)
  end

  def intellect_modifier
    modifier(@intellect)
  end

  def personality_modifier
    modifier(@personality)
  end

  def speed_modifier
    modifier(@speed)
  end

  def luck_modifier
    modifier(@luck)
  end

  private

  def modifier(stat)
    (stat - 10) / 2
  end
end
