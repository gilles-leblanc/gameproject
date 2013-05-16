class TreasureTable
	def self.small_amount_of_gold
		treasure = Array.new
		treasure.push([:gold, (1..5).to_a.shuffle.first])
		treasure
  end

  def self.medium_amount_of_gold
    treasure = Array.new
    treasure.push([:gold, (3..10).to_a.shuffle.first])
    treasure
  end

  def self.large_amount_of_gold
    treasure = Array.new
    treasure.push([:gold, (15..25).to_a.shuffle.first])
    treasure
  end

  def self.very_large_amount_of_gold
    treasure = Array.new
    treasure.push([:gold, (25..50).to_a.shuffle.first])
    treasure
  end

  def self.random_amount_of_gold
    treasure = Array.new
    treasure.push([:gold, (3..25).to_a.shuffle.first])
    treasure
  end
end
