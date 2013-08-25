require_relative './items/item_generator'
require_relative './items/weapons'
require_relative './items/armors'
require_relative './items/shields'

# Class that generates random different kinds of random treasure.
class TreasureTable
  @@random = Random.new

  def initialize
    @armor_generator = ItemGenerator.new([PaddedArmor.new, LeatherArmor.new,
                                          ChainMail.new, ScaleArmor.new,
                                          PlateMail.new, FullPlate.new, Buckler.new,
                                          MediumShield.new, LargeShield.new])

    @weapon_generator = ItemGenerator.new([Dagger.new, LongDagger.new, ShortSword.new,
                                           LongSword.new, Club.new, Mace.new, Flail.new,
                                           MorningStar.new, Staff.new, Spear.new,
                                           HandAxe.new])
  end

  def self.small_amount_of_gold
    treasure = []
    treasure.push([:gold, @@random.rand(1..5)])
    treasure
  end

  def self.medium_amount_of_gold
    treasure = []
    treasure.push([:gold, @@random.rand(3..10)])
    treasure
  end

  def self.large_amount_of_gold
    treasure = []
    treasure.push([:gold, @@random.rand(15..25)])
    treasure
  end

  def self.very_large_amount_of_gold
    treasure = []
    treasure.push([:gold, @@random.rand(25..50)])
    treasure
  end

  def self.random_amount_of_gold
    treasure = []
    treasure.push([:gold, @@random.rand(3..25)])
    treasure
  end

  def one_item
    pick_one_item
  end

  def small_chance_for_one_item
    pick_one_item if @@random.rand(1..10) < 3
  end

  def chance_for_one_item
    pick_one_item if @@random.rand(1..10) <= 5
  end

  private

  def pick_one_item
    item_level = @@random.rand(-3..4)

    if [true, false].sample
      @armor_generator.generate(item_level)
    else
      @weapon_generator.generate(item_level)
    end
  end
end
