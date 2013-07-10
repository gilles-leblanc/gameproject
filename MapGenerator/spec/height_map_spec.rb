require_relative '../height_map'
require_relative '../gaussian_filter'
require_relative '../height_map_configurator'

describe HeightMap do
  scan_edge_for_particles = Proc.new do |map|
    particles_on_edge = false

    for y in 0...60
      for x in if y != 0 && y != 59 then
                 [0, 59]
               else
                 0...60
               end
        particles_on_edge = true if map.data[x + y * 60] > 0
      end
    end

    particles_on_edge
  end

  before(:each) do
    @height_map = HeightMap.new
    @existing_array = Array.new(100).map { rand 4 }
  end

  specify "when loading an existing height map array" do
    @height_map.load(@existing_array, 10)
    @height_map.data.should equal @existing_array
  end

  specify "when generating an height map" do
    @height_map.generate(60, 60)
    @height_map.visit(scan_edge_for_particles).should be_false
  end

  context "filter" do
    before(:each) do
      @blur_filter = GaussianFilter.new
    end

    it "should not modify the original map" do
      @height_map.load(@existing_array, 10)
      @height_map.filter(@blur_filter)
      @height_map.data.should equal @existing_array
    end

    it "should return a modified map" do
      @height_map.load(@existing_array, 10)
      filtered = @height_map.filter(@blur_filter)
      @height_map.data.should_not == filtered.data
    end

    it "should not create particles on edge of map" do
      @height_map.generate(60, 60)
      filtered = @height_map.filter(@blur_filter)
      filtered.visit(scan_edge_for_particles).should be_false
    end
  end
end
