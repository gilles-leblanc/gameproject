require '../probability_table'
require '../two_letter_length_strategy'
require '../three_letter_length_strategy'
require '../input_loader'

describe "ProbabilityTable" do
  describe "#build" do

    context "when using a two letter length strategy" do
      before(:each) do
        two_letter_length_strategy = TwoLetterLengthStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @probability_table = ProbabilityTable.new(two_letter_length_strategy, memory_input_loader)
      end

      it { @probability_table.empty?.should be_true }

      context "when using an empty input" do
        before(:each) do
          @probability_table.load("")
        end

        it { @probability_table.empty?.should be_true }
      end

      context "when using a simple input" do
        before(:each) do
          @input = " abcdefg "
          @probability_table.load(@input)
        end

        it { @probability_table.empty?.should be_false }
        it { @probability_table.frequencies.length.should == @input.length - 1 }
        it { @probability_table.frequencies[" a"].should == 1.0 }
        it { @probability_table.frequencies["ab"].should == 1.0 }
        it { @probability_table.frequencies["bc"].should == 1.0 }
        it { @probability_table.frequencies["cd"].should == 1.0 }
        it { @probability_table.frequencies["de"].should == 1.0 }
        it { @probability_table.frequencies["ef"].should == 1.0 }
        it { @probability_table.frequencies["fg"].should == 1.0 }
        it { @probability_table.frequencies["g "].should == 1.0 }
      end

      context "when using a more complex input" do
        before(:each) do
          @input = " James John Max Gary Jess Gilles Mary "
          @probability_table.load(@input)
        end

        it { @probability_table.frequencies[" j"].should == 0.42857142857142855 }
        it { @probability_table.frequencies[" m"].should == 0.2857142857142857 }
        it { @probability_table.frequencies[" g"].should == 0.2857142857142857 }

        # we treat pairs ending with a space as a special case, they are grouped in their own category rather than
        # being with their first letter
        it { @probability_table.frequencies["n "].should == 0.142857143 }
        it { @probability_table.frequencies["s "].should == 0.428571429 }
        it { @probability_table.frequencies["x "].should == 0.142857143 }
        it { @probability_table.frequencies["y "].should == 0.285714286 }

        it { @probability_table.frequencies["ax"].should == 0.25 }
        it { @probability_table.frequencies["ar"].should == 0.5 }
        it { @probability_table.frequencies["am"].should == 0.25 }

        it { @probability_table.frequencies["es"].should == 1.0 }

        it { @probability_table.frequencies["ga"].should == 0.5 }
        it { @probability_table.frequencies["gi"].should == 0.5 }

        it { @probability_table.frequencies["hn"].should == 1.0 }

        it { @probability_table.frequencies["il"].should == 1.0 }

        it { @probability_table.frequencies["ja"].should == 0.3333333333333333 }
        it { @probability_table.frequencies["jo"].should == 0.3333333333333333 }
        it { @probability_table.frequencies["je"].should == 0.3333333333333333 }

        it { @probability_table.frequencies["ll"].should == 0.5 }
        it { @probability_table.frequencies["le"].should == 0.5 }

        it { @probability_table.frequencies["oh"].should == 1.0 }

        it { @probability_table.frequencies["ma"].should == 0.6666666666666666 }
        it { @probability_table.frequencies["me"].should == 0.3333333333333333 }

        it { @probability_table.frequencies["ry"].should == 1.0 }

        it { @probability_table.frequencies["ss"].should == 1.0 }
      end
    end

    context "when using a three letter length strategy" do
      before(:each) do
        three_letter_length_strategy = ThreeLetterLengthStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @probability_table = ProbabilityTable.new(three_letter_length_strategy, memory_input_loader)
      end

      it { @probability_table.empty?.should be_true }

      context "when using an empty input" do
        before(:each) do
          @probability_table.load("")
        end

        it { @probability_table.empty?.should be_true }
      end

      context "when using a simple input" do
        before(:each) do
          @input = " abcdefg "
          @probability_table.load(@input)
        end

        it { @probability_table.empty?.should be_false }
        it { @probability_table.frequencies.length.should == @input.length - 2 }
        it { @probability_table.frequencies[" ab"].should == 1.0 }
        it { @probability_table.frequencies["abc"].should == 1.0 }
        it { @probability_table.frequencies["bcd"].should == 1.0 }
        it { @probability_table.frequencies["cde"].should == 1.0 }
        it { @probability_table.frequencies["def"].should == 1.0 }
        it { @probability_table.frequencies["efg"].should == 1.0 }
        it { @probability_table.frequencies["fg "].should == 1.0 }
      end

      #context "when using a more complex input" do
      #  before(:each) do
      #    @input = " James John Max Gary Jess Gilles Mary "
      #    @probability_table.load(@input)
      #  end
      #
      #  it { @probability_table.frequencies[" ga"].should == 0.0 }
      #  it { @probability_table.frequencies[" gi"].should == 0.0 }
      #  it { @probability_table.frequencies[" ja"].should == 0.0 }
      #  it { @probability_table.frequencies[" je"].should == 0.0 }
      #  it { @probability_table.frequencies[" jo"].should == 0.0 }
      #  it { @probability_table.frequencies[" jo"].should == 0.0 }
      #  it { @probability_table.frequencies[" ma"].should == 0.0 }
      #  it { @probability_table.frequencies[" ma"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["ame"].should == 0.0 }
      #  it { @probability_table.frequencies["ary"].should == 0.0 }
      #  it { @probability_table.frequencies["ary"].should == 0.0 }
      #  it { @probability_table.frequencies["ax "].should == 0.0 }
      #
      #  it { @probability_table.frequencies["es "].should == 0.0 }
      #  it { @probability_table.frequencies["es "].should == 0.0 }
      #  it { @probability_table.frequencies["ess"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["gar"].should == 0.0 }
      #  it { @probability_table.frequencies["gil"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["hn "].should == 0.0 }
      #
      #  it { @probability_table.frequencies["ill"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["jam"].should == 0.0 }
      #  it { @probability_table.frequencies["jes"].should == 0.0 }
      #  it { @probability_table.frequencies["joh"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["les"].should == 0.0 }
      #  it { @probability_table.frequencies["lle"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["mar"].should == 0.0 }
      #  it { @probability_table.frequencies["max"].should == 0.0 }
      #  it { @probability_table.frequencies["mes"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["ohn"].should == 0.0 }
      #
      #  it { @probability_table.frequencies["ry "].should == 0.0 }
      #  it { @probability_table.frequencies["ry "].should == 0.0 }
      #
      #  it { @probability_table.frequencies["ss "].should == 0.0 }
      #
      #  # we do not want probabilities for word-ending, space, word-beginning
      #  it { @probability_table.frequencies.key?("s j").should be_false }
      #  it { @probability_table.frequencies.key?("n m").should be_false }
      #  it { @probability_table.frequencies.key?("x g").should be_false }
      #  it { @probability_table.frequencies.key?("y j").should be_false }
      #  it { @probability_table.frequencies.key?("s g").should be_false }
      #  it { @probability_table.frequencies.key?("s m").should be_false }
      #end
    end

    context "when using the file_input_loader" do
      before(:each) do
        two_letter_length_strategy = TwoLetterLengthStrategy.new
        memory_input_loader = FileInputLoader.new

        @probability_table = ProbabilityTable.new(two_letter_length_strategy, memory_input_loader)
      end

      context "when using an empty file as input" do
        before(:each) do
          file_name = "empty_file"
          File.open(file_name, 'w') {|f| f.write("") }
          @probability_table.load(file_name)
        end

        it { @probability_table.empty?.should be_true }
      end

      context "when using a simple file as input" do
        before(:each) do
          file_name = "empty_file"
          @input = " abcdefg "
          File.open(file_name, 'w') {|f| f.write(@input) }
          @probability_table.load(file_name)
        end

        it { @probability_table.empty?.should be_false }
        it { @probability_table.frequencies.length.should == @input.length - 1 }
      end
    end
  end
end
class TwoLetterLengthStrategy

end