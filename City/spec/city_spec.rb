require_relative '../test_city_factory'

describe "City" do
	before(:each) do
    city_factory = TestCityFactory.new
    @city = city_factory.build
  end
	
	subject { @city }
	
	it { should respond_to :name }
	specify { :name.should_not be_empty }
	
	# the four corners should be walls
	specify { @city.tile_at(0, 0).type.should be :wall }
	specify { @city.tile_at(19, 0).type.should be :wall }
	specify { @city.tile_at(0, 19).type.should be :wall }
	specify { @city.tile_at(19, 19).type.should be :wall }
	
	# should have exactly one entrance
	it { @city.tiles.one? {|tile| tile.type == :entrance}.should be_true }
	
	it "should be surrounded by a wall, except for one square" do
		number_of_wall_tiles = 0
		
		for x in 0...20
  		number_of_wall_tiles += 1 if @city.tile_at(x, 0).type == :wall
  		number_of_wall_tiles += 1 if @city.tile_at(x, 18).type == :wall
  	end
  	
  	for y in 1...19
  		number_of_wall_tiles += 1 if @city.tile_at(0, y).type == :wall
  		number_of_wall_tiles += 1 if @city.tile_at(18, y).type == :wall
  	end
  	
  	number_of_wall_tiles.should == 75
	end
	
	specify "the entrance should not be close to a corner" do
		not_close = @city.tiles.select {|tile| 
													!(tile.x < 5 && tile.y == 0) &&
												  !(tile.x > 15 && tile.y == 0) &&
												  !(tile.x < 5 && tile.y == 19) &&
												  !(tile.x > 15 && tile.y == 19) &&
												  !(tile.x == 0 && tile.y < 5) &&
												  !(tile.x == 0 && tile.y > 15) &&
												  !(tile.x == 19 && tile.y < 5) &&
												  !(tile.x == 19 && tile.y > 15)}
		
		entrance = not_close.select {|tile| tile.type == :entrance}.first
		
		entrance.should_not be_nil
	end	
end
