require './map_factory'

describe MapFactory, "map creation" do
  it "should return a new Map instance" do
    map = MapFactory.make(20, 20)  
    map.should be_an_instance_of(WorldMap)
  end
  
  it "should be a map of the specified size" do
  	map = MapFactory.make(20, 20)
  	map.width.should equal(20)
  	map.height.should equal(20)
  	map.tiles.length.should equal(400)
  end
  
  it "should be an island and have water all around it" do
  	map = MapFactory.make(60, 60)
  	
  	for x in 0...map.width
  		map.tile_at(x, 0).type.should eq(:water)
  		map.tile_at(x, 59).type.should eq(:water)
  	end
  	
  	for y in 0...map.height
  		map.tile_at(0, y).type.should eq(:water)
  		map.tile_at(59, y).type.should eq(:water)
  	end
  end
  
  it "should have more than half the tiles be landmass" do	
  	map = MapFactory.make(40, 40)
  	
  	number_of_water_tiles = map.tiles.count{|tile| tile.type == :water} 
  	  	
  	number_of_water_tiles.should be < 1600
  end
    
  it "should support maps larger than 100 by 100 tiles" do
  	map = MapFactory.make(101, 101)
		map.should be_an_instance_of(WorldMap)  	
  end
  
  it "should include grass tiles" do
  	map = MapFactory.make(40, 40)
  	any_grass_tiles = map.tiles.any? {|tile| tile.type == :grass}
  	any_grass_tiles.should be_true
  end
  
  it "should include forest tiles" do
  	map = MapFactory.make(40, 40)
  	any_forest_tiles = map.tiles.any? {|tile| tile.type == :forest}
  	any_forest_tiles.should be_true	
  end
  
  it "should include mountain tiles" do
  	map = MapFactory.make(40, 40)
  	any_mountain_tiles = map.tiles.any? {|tile| tile.type == :mountain}
  	any_mountain_tiles.should be_true	
  end
end
