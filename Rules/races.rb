# Different races for the player characters. Races apply stat bonuses but could also
# add different bonus to thievery or give certain skills.

class Human
  def apply_stat_mods(stats)
  end
end

class Elf
  def apply_stat_mods(stats)
    stats.might -= 1
    stats.accuracy += 1
    stats.endurance -= 1
    stats.intellect += 1
  end
end

class Dwarf
  def apply_stat_mods(stats)
    stats.intellect -= 1
    stats.endurance += 1
    stats.speed -= 1
    stats.luck += 1
  end
end

class Gnome
  def apply_stat_mods(stats)
    stats.speed -= 1
    stats.accuracy -=1
    stats.luck += 2
  end
end

class HalfOrc
  def apply_stat_mods(stats)
    stats.might += 1
    stats.intellect -= 1
    stats.personality -= 1
    stats.endurance += 1
    stats.luck -= 1
  end
end
