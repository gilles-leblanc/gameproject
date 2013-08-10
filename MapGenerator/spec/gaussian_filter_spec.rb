require_relative '../gaussian_filter'

describe GaussianFilter do
  before(:each) do
    @gaussian_filter = GaussianFilter.new
  end

  specify 'filtered values should not bleed over horizontally' do
    sample_array = [0, 0, 5, 5, 6, 7, 10, 100, 200, 100, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    filtered_array = @gaussian_filter.filter sample_array

    for x in 0...13
      filtered_array[x + 12 * 13].should == 0
    end
  end

  specify 'filtered values should not bleed over vertically' do
    sample_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    filtered_array = @gaussian_filter.filter sample_array

    for y in 0...13
      filtered_array[12 + y * 13].should == 0
    end
  end

  specify 'double filtering should not bleed over horizontally' do
    sample_array = [0, 0, 5, 5, 6, 7, 10, 100, 200, 100, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    filtered_array = @gaussian_filter.filter sample_array
    filtered_twice = @gaussian_filter.filter filtered_array

    for x in 0...13
      filtered_twice[x + 12 * 13].should == 0
    end
  end

  specify 'double filtering should not bleed over vertically' do
    sample_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    filtered_array = @gaussian_filter.filter sample_array
    filtered_twice = @gaussian_filter.filter filtered_array

    for y in 0...13
      filtered_twice[12 + y * 13].should == 0
    end
  end

  specify 'filtering should be symmetrical', symmetrical: true do
    sample_array = [0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 100, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0]

    filtered_array = @gaussian_filter.filter sample_array

    filtered_array[1 + 1 * 7].should == filtered_array[5 + 1 * 7]
    filtered_array[1 + 2 * 7].should == filtered_array[5 + 2 * 7]
    filtered_array[1 + 3 * 7].should == filtered_array[5 + 3 * 7]
    filtered_array[1 + 4 * 7].should == filtered_array[5 + 4 * 7]
    filtered_array[1 + 5 * 7].should == filtered_array[5 + 5 * 7]

    filtered_array[2 + 1 * 7].should == filtered_array[4 + 1 * 7]
    filtered_array[2 + 2 * 7].should == filtered_array[4 + 2 * 7]
    filtered_array[2 + 3 * 7].should == filtered_array[4 + 3 * 7]
    filtered_array[2 + 4 * 7].should == filtered_array[4 + 4 * 7]
    filtered_array[2 + 5 * 7].should == filtered_array[4 + 5 * 7]

    filtered_array[3 + 1 * 7].should == filtered_array[3 + 5 * 7]
    filtered_array[3 + 2 * 7].should == filtered_array[3 + 4 * 7]
  end
end

