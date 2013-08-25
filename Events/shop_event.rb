require_relative '../broadcast'
require_relative '../Rules/items/armors'
require_relative '../Rules/items/weapons'

# The event that happens when the party enters a shop building in a city.
class ShopEvent
  include Broadcast

  def initialize(shop_name)
    @shop_name = shop_name
    @inventory = []
  end

  def act
    broadcast "Shop: Welcome to #{@shop_name}."
  end
end
