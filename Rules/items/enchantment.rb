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

