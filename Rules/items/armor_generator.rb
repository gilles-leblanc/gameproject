require_relative 'armors'
require_relative 'shields'
require_relative 'enchantment'

# Generate a random piece of armor. To be used for treasure generation
# (monsters, treasure chests, etc.) and shop item generation.
class ArmorGenerator
  def generate(item_level = 0)
    # generate base item
    armors = [PaddedArmor.new, LeatherArmor.new, ChainMail.new,
              ScaleArmor.new, PlateMail.new, FullPlate.new,
              Buckler.new, MediumShield.new, LargeShield.new]

    armor = armors.shuffle.first

    # add enchantments for appropriate item_level
    material_enchantments = [Enchantment.null_object, Grass.new, Wooden.new,
                             Leather.new, Bronze.new, Iron.new, Steel.new,
                             Silvered.new, Platinum.new, Mithril.new,
                             Adamantine.new, Obsidian.new, Crystal.new,
                             Meteorite.new]

    armor.material_enchantment = material_enchantments.select { |e| e.bonus_item_level == item_level }.shuffle().first
    armor
  end
end

generator = ArmorGenerator.new
puts generator.generate(1)