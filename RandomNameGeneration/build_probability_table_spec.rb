require './build_probability_table'

describe "the build probability tables script" do	
	before(:all) do
		File.open("test/one_seed_letter_test", "w") do |file|
			puts " abc aab aqw aer aqr"
		end
	end

	# by seed letter, I mean the first letter of a pair or triplet
	it "should provide the correct probabilities for one seed letter" do	
		system("ruby", "build_probability_table.rb", "test/one_seed_letter_test", "test/test_out")
		
		lines = File.readlines("test/test_out")
		puts lines
		lines[0].include?("! ' aa': 0.").should be_true
		lines[1].include?("! ' ab': 0.").should be_true
		lines[2].include?("! ' ae': 0.").should be_true
		lines[3].include?("! ' aq': 0.").should be_true
	end
end
