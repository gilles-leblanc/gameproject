#require '../build_probability_table'

describe "the build probability tables script" do	
	context 'with text file containing " abcdefg " as input' do
		before(:each) do
			input_filename = "text_file_abcdefg" 
			output_filename = "test_out"
		
			File.open(input_filename, 'w') {|file| file.write(" abcdefg ") }
			
			system("ruby", "../build_probability_table.rb", input_filename, output_filename)			
			@lines = File.readlines(output_filename)
		end
		
		it { @lines[0].chomp.should eq("---") }
		it { @lines[1].chomp.should eq(" a: 1.0") }
	end	
end
