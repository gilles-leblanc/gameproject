require_relative 'enchantment'

# Generate a random item. To be used for treasure generation
# (monsters, treasure chests, etc.) and shop item generation.
class ItemGenerator
  def initialize(item_list)
    @item_list = item_list
  end

  def generate(item_level = 0)
    @item = @item_list.shuffle.first
    add_material_enchantment(item_level)

    @item
  end

  private

  # add material enchantment for appropriate item_level
  def add_material_enchantment(item_level)
    material_enchantments = [Enchantment.null_object, Grass.new, Wooden.new,
                             Leather.new, Bronze.new, Iron.new, Steel.new,
                             Silvered.new, Platinum.new, Mithril.new,
                             Adamantine.new, Obsidian.new, Crystal.new,
                             Meteorite.new]

    @item.material_enchantment =
        material_enchantments.select { |e| e.bonus_item_level == item_level }
                              .shuffle.first
  end
end
