require_relative '../test_city_factory'

describe "Buildings in a city" do
  describe "#load" do
    before(:all) do
      city_factory = TestCityFactory.new
      @city = city_factory.build
    end

    it { @city.tiles.one? { |tile| tile.type == :door && tile.event.class == ShopEvent }.should be_true }
    it { @city.tiles.one? { |tile| tile.type == :door && tile.event.class == InnEvent }.should be_true }
    it { @city.tiles.one? { |tile| tile.type == :door && tile.event.class == TempleEvent }.should be_true }
    it { @city.tiles.one? { |tile| tile.type == :door && tile.event.class == GuildEvent }.should be_true }
  end
end