require_relative '../broadcast'

# The event that happens when the party enters a shop building in a city.
class ShopEvent
  include Broadcast

  def initialize(shop_name)
    @shop_name = shop_name
  end

  def act
    broadcast "Shop: Welcome to #{@shop_name}."

  end
end