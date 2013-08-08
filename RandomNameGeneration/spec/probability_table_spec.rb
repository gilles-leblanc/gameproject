require_relative '../probability_table'
require_relative '../two_letter_length_strategy'
require_relative '../three_letter_length_strategy'
require_relative '../input_loader'

describe 'ProbabilityTable' do
  describe '#load' do

    context 'when using a two letter length strategy' do
      before(:all) do
        two_letter_length_strategy = TwoLetterLengthStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @probability_table = ProbabilityTable.new(two_letter_length_strategy, memory_input_loader)
      end

      it { @probability_table.empty?.should be_true }

      context 'when using an empty input' do
        before(:all) do
          @probability_table.load('')
        end

        it { @probability_table.empty?.should be_true }
      end

      context 'when using a simple input' do
        before(:all) do
          @probability_table.load(' abcdefg ')
        end

        it { @probability_table.empty?.should be_false }
        it { @probability_table.frequencies.length.should == 8 }
        it { @probability_table.frequencies[' a'].should == 1.0 }
        it { @probability_table.frequencies['ab'].should == 1.0 }
        it { @probability_table.frequencies['bc'].should == 1.0 }
        it { @probability_table.frequencies['cd'].should == 1.0 }
        it { @probability_table.frequencies['de'].should == 1.0 }
        it { @probability_table.frequencies['ef'].should == 1.0 }
        it { @probability_table.frequencies['fg'].should == 1.0 }
        it { @probability_table.frequencies['g '].should == 1.0 }
      end

      context 'when using a more complex input' do
        before(:all) do
          @probability_table.load(' James John Max Gary Jess Gilles Mary ')
        end

        it { @probability_table.frequencies[' j'].should == 0.42857142857142855 }
        it { @probability_table.frequencies[' m'].should == 0.2857142857142857 }
        it { @probability_table.frequencies[' g'].should == 0.2857142857142857 }

        # we treat pairs ending with a space as a special case, they are grouped in their own category rather than
        # being with their first letter
        it { @probability_table.frequencies['n '].should == 0.14285714285714285 }
        it { @probability_table.frequencies['s '].should == 0.42857142857142855 }
        it { @probability_table.frequencies['x '].should == 0.14285714285714285 }
        it { @probability_table.frequencies['y '].should == 0.2857142857142857 }

        it { @probability_table.frequencies['ax'].should == 0.25 }
        it { @probability_table.frequencies['ar'].should == 0.5 }
        it { @probability_table.frequencies['am'].should == 0.25 }

        it { @probability_table.frequencies['es'].should == 1.0 }

        it { @probability_table.frequencies['ga'].should == 0.5 }
        it { @probability_table.frequencies['gi'].should == 0.5 }

        it { @probability_table.frequencies['hn'].should == 1.0 }

        it { @probability_table.frequencies['il'].should == 1.0 }

        it { @probability_table.frequencies['ja'].should == 0.3333333333333333 }
        it { @probability_table.frequencies['jo'].should == 0.3333333333333333 }
        it { @probability_table.frequencies['je'].should == 0.3333333333333333 }

        it { @probability_table.frequencies['ll'].should == 0.5 }
        it { @probability_table.frequencies['le'].should == 0.5 }

        it { @probability_table.frequencies['oh'].should == 1.0 }

        it { @probability_table.frequencies['ma'].should == 0.6666666666666666 }
        it { @probability_table.frequencies['me'].should == 0.3333333333333333 }

        it { @probability_table.frequencies['ry'].should == 1.0 }

        it { @probability_table.frequencies['ss'].should == 1.0 }
      end
    end

    context 'when using a three letter length strategy' do
      before(:all) do
        three_letter_length_strategy = ThreeLetterLengthStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @probability_table = ProbabilityTable.new(three_letter_length_strategy, memory_input_loader)
      end

      it { @probability_table.empty?.should be_true }

      context 'when using an empty input' do
        before(:all) do
          @probability_table.load('')
        end

        it { @probability_table.empty?.should be_true }
      end

      context 'when using a simple input' do
        before(:all) do
          @probability_table.load(' abcdefg ')
        end

        it { @probability_table.empty?.should be_false }
        it { @probability_table.frequencies.length.should == 7 }
        it { @probability_table.frequencies[' ab'].should == 1.0 }
        it { @probability_table.frequencies['abc'].should == 1.0 }
        it { @probability_table.frequencies['bcd'].should == 1.0 }
        it { @probability_table.frequencies['cde'].should == 1.0 }
        it { @probability_table.frequencies['def'].should == 1.0 }
        it { @probability_table.frequencies['efg'].should == 1.0 }
        it { @probability_table.frequencies['fg '].should == 1.0 }
      end

      context 'when using a more complex input' do
        before(:all) do
          @probability_table.load(' James John Max Gary Jess Gilles Mary ')
        end

        it { @probability_table.frequencies[' ga'].should == 0.5 }
        it { @probability_table.frequencies[' gi'].should == 0.5 }
        it { @probability_table.frequencies[' ja'].should == 0.3333333333333333 }
        it { @probability_table.frequencies[' je'].should == 0.3333333333333333 }
        it { @probability_table.frequencies[' jo'].should == 0.3333333333333333 }
        it { @probability_table.frequencies[' ma'].should == 1.0 }

        it { @probability_table.frequencies['ax '].should == 1.0 }
        it { @probability_table.frequencies['es '].should == 1.0 }
        it { @probability_table.frequencies['hn '].should == 1.0 }
        it { @probability_table.frequencies['ry '].should == 1.0 }
        it { @probability_table.frequencies['ss '].should == 1.0 }

        it { @probability_table.frequencies['ame'].should == 1.0 }
        it { @probability_table.frequencies['ary'].should == 1.0 }

        it { @probability_table.frequencies['ess'].should == 1.0 }

        it { @probability_table.frequencies['gar'].should == 1.0 }
        it { @probability_table.frequencies['gil'].should == 1.0 }

        it { @probability_table.frequencies['ill'].should == 1.0 }

        it { @probability_table.frequencies['jam'].should == 1.0 }
        it { @probability_table.frequencies['jes'].should == 1.0 }
        it { @probability_table.frequencies['joh'].should == 1.0 }

        it { @probability_table.frequencies['les'].should == 1.0 }
        it { @probability_table.frequencies['lle'].should == 1.0 }

        it { @probability_table.frequencies['mar'].should == 0.5 }
        it { @probability_table.frequencies['max'].should == 0.5 }
        it { @probability_table.frequencies['mes'].should == 1.0 }

        it { @probability_table.frequencies['ohn'].should == 1.0 }

        # we do not want probabilities with spaces in the middle for three letter triplets
        it { @probability_table.frequencies.key?('s j').should be_false }
        it { @probability_table.frequencies.key?('n m').should be_false }
        it { @probability_table.frequencies.key?('x g').should be_false }
        it { @probability_table.frequencies.key?('y j').should be_false }
        it { @probability_table.frequencies.key?('s g').should be_false }
        it { @probability_table.frequencies.key?('s m').should be_false }
      end

      context 'when using input with multiple word endings' do
        before(:all) do
          @probability_table.load(' James Joes Max Garal Jert Gilles Mary Bob ')
        end

        it { @probability_table.frequencies['es '].should == 1.0 }
        it { @probability_table.frequencies['al '].should == 0.5 }
        it { @probability_table.frequencies['ax '].should == 0.5 }
        it { @probability_table.frequencies['ob '].should == 1.0 }
        it { @probability_table.frequencies['rt '].should == 0.5 }
        it { @probability_table.frequencies['ry '].should == 0.5 }
      end
    end
  end

  context 'when using the file_input_loader' do
    before(:all) do
      two_letter_length_strategy = TwoLetterLengthStrategy.new
      memory_input_loader = FileInputLoader.new

      @probability_table = ProbabilityTable.new(two_letter_length_strategy, memory_input_loader)
    end

    context 'when using an empty file as input' do
      before(:all) do
        file_name = 'empty_file'
        File.open(file_name, 'w') { |f| f.write('') }
        @probability_table.load(file_name)
      end

      it { @probability_table.empty?.should be_true }
    end

    context 'when using a simple file as input' do
      before(:all) do
        file_name = 'empty_file'
        @input = ' abcdefg '
        File.open(file_name, 'w') { |f| f.write(@input) }
        @probability_table.load(file_name)
      end

      it { @probability_table.empty?.should be_false }
      it { @probability_table.frequencies.length.should == @input.length - 1 }
    end
  end
end
