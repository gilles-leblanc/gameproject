class Enchantment
  attr_accessor :name, :stat_modifier, :bonus_item_level, :item_value_modifier

  protected

  def self.null_object
    null_object_enchantment = Enchantment.new
    null_object_enchantment.name = ""
    null_object_enchantment.stat_modifier = 0
    null_object_enchantment.bonus_item_level = 0
    null_object_enchantment.item_value_modifier = 0

    null_object_enchantment
  end
end

## Material Enchantments

class Grass < Enchantment
  def initialize
    @name = "Grass"
    @stat_modifier = -3
    @bonus_item_level = 0
    @item_value_modifier = 0.1
  end
end

class Wooden < Enchantment
  def initialize
    @name = "Wooden"
    @stat_modifier = -2
    @bonus_item_level = 0
    @item_value_modifier = 0.25
  end
end

class Leather < Enchantment
  def initialize
    @name = "Leather"
    @stat_modifier = -1
    @bonus_item_level = 0
    @item_value_modifier = 0.5
  end
end

class Bronze < Enchantment
  def initialize
    @name = "Bronze"
    @stat_modifier = 0
    @bonus_item_level = 0
    @item_value_modifier = 1
  end
end

class Iron < Enchantment
  def initialize
    @name = "Iron"
    @stat_modifier = 1
    @bonus_item_level = 0
    @item_value_modifier = 1.1
  end
end

class Steel < Enchantment
  def initialize
    @name = "Steel"
    @stat_modifier = 2
    @bonus_item_level = 1
    @item_value_modifier = 1.25
  end
end

class Silvered < Enchantment
  def initialize
    @name = "Silvered"
    @stat_modifier = 3
    @bonus_item_level = 1
    @item_value_modifier = 1.5
  end
end

class Platinum < Enchantment
  def initialize
    @name = "Platinum"
    @stat_modifier = 4
    @bonus_item_level = 2
    @item_value_modifier = 2
  end
end

class Mithril < Enchantment
  def initialize
    @name = "Mithril"
    @stat_modifier = 5
    @bonus_item_level = 2
    @item_value_modifier = 2.5
  end
end

class Adamantine < Enchantment
  def initialize
    @name = "Adamantine"
    @stat_modifier = 6
    @bonus_item_level = 2
    @item_value_modifier = 2.75
  end
end

class Obsidian < Enchantment
  def initialize
    @name = "Obsidian"
    @stat_modifier = 7
    @bonus_item_level = 3
    @item_value_modifier = 3
  end
end

class Crystal < Enchantment
  def initialize
    @name = "Crystal"
    @stat_modifier = 8
    @bonus_item_level = 3
    @item_value_modifier = 3.25
  end
end

class Meteorite < Enchantment
  def initialize
    @name = "Meteorite"
    @stat_modifier = 9
    @bonus_item_level = 4
    @item_value_modifier = 5
  end
end