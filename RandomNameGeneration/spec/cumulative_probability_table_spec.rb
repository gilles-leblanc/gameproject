require_relative '../probability_table'
require_relative '../cumulative_probability_table'
require_relative '../two_letter_length_strategy'
require_relative '../two_letter_cumulative_strategy'
require_relative '../three_letter_length_strategy'
require_relative '../three_letter_cumulative_strategy'
require_relative '../input_loader'

describe 'CumulativeProbabilityTable' do
  describe '#load' do
    context 'when using a two letter cumulative strategy' do
      before(:all) do
        two_letter_length_strategy = TwoLetterLengthStrategy.new
        two_letter_cumulative_strategy = TwoLetterCumulativeStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @cumulative_probability_table = CumulativeProbabilityTable.new(
            two_letter_length_strategy, two_letter_cumulative_strategy,
            memory_input_loader)

        @cumulative_probability_table.load(' James John Max Gary Jess Gilles Mary ')
      end

      it { @cumulative_probability_table.frequencies[' g'].should == 0.2857142857142857 }
      it { @cumulative_probability_table.frequencies[' j'].should == 0.7142857142857142 }
      it { @cumulative_probability_table.frequencies[' m'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['n '].should == 0.14285714285714285 }
      it { @cumulative_probability_table.frequencies['s '].should == 0.5714285714285714 }
      it { @cumulative_probability_table.frequencies['x '].should == 0.7142857142857142 }
      it { @cumulative_probability_table.frequencies['y '].should == 1.0 }

      it { @cumulative_probability_table.frequencies['am'].should == 0.25 }
      it { @cumulative_probability_table.frequencies['ar'].should == 0.75 }
      it { @cumulative_probability_table.frequencies['ax'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['es'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['ga'].should == 0.5 }
      it { @cumulative_probability_table.frequencies['gi'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['hn'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['il'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['ja'].should == 0.3333333333333333 }
      it { @cumulative_probability_table.frequencies['je'].should == 0.6666666666666666 }
      it { @cumulative_probability_table.frequencies['jo'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['le'].should == 0.5 }
      it { @cumulative_probability_table.frequencies['ll'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['oh'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['ma'].should == 0.6666666666666666 }
      it { @cumulative_probability_table.frequencies['me'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['ry'].should == 1.0 }

      it { @cumulative_probability_table.frequencies['ss'].should == 1.0 }
    end

    context 'when using a three letter cumulative strategy' do
      before(:all) do
        three_letter_length_strategy = ThreeLetterLengthStrategy.new
        three_letter_cumulative_strategy = ThreeLetterCumulativeStrategy.new
        memory_input_loader = MemoryInputLoader.new

        @cumulative_probability_table = CumulativeProbabilityTable.new(
            three_letter_length_strategy, three_letter_cumulative_strategy,
            memory_input_loader)
      end

      context 'when using a complex input' do
        before(:all) do
          @cumulative_probability_table.load(' James John Max Gary Jess Gilles Mary ')
        end

        it { @cumulative_probability_table.frequencies[' ga'].should == 0.5 }
        it { @cumulative_probability_table.frequencies[' gi'].should == 1.0 }
        it { @cumulative_probability_table.frequencies[' ja'].should == 0.3333333333333333 }
        it { @cumulative_probability_table.frequencies[' je'].should == 0.6666666666666666 }
        it { @cumulative_probability_table.frequencies[' jo'].should == 1.0 }
        it { @cumulative_probability_table.frequencies[' ma'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['ax '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['es '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['hn '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['ry '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['ss '].should == 1.0 }

        it { @cumulative_probability_table.frequencies['ame'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['ary'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['ess'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['gar'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['gil'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['ill'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['jam'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['jes'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['joh'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['les'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['lle'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['mar'].should == 0.5 }
        it { @cumulative_probability_table.frequencies['max'].should == 1.0 }
        it { @cumulative_probability_table.frequencies['mes'].should == 1.0 }

        it { @cumulative_probability_table.frequencies['ohn'].should == 1.0 }
      end

      context 'when using input with multiple word endings' do
        before(:all) do
          @cumulative_probability_table.load(' James Joes Max Garal Jert Gilles Mary Bob ')
        end

        it { @cumulative_probability_table.frequencies['es '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['al '].should == 0.5 }
        it { @cumulative_probability_table.frequencies['ax '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['ob '].should == 1.0 }
        it { @cumulative_probability_table.frequencies['rt '].should == 0.5 }
        it { @cumulative_probability_table.frequencies['ry '].should == 1.0 }
      end
    end
  end
end