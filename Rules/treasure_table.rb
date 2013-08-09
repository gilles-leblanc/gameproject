# Class that generates random different kinds of random treasure.
class TreasureTable
  @@random = Random.new

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
end
