require_relative '../effects'

describe 'Effects' do
  before(:each) do
    @effects = {:ac => [], :hp => [], :might => [], :mp => [], :luck => []}

    @effects[:ac].push([2, 1])
    @effects[:ac].push([2, 2])

    @effects[:hp].push([2, 1])
    @effects[:hp].push([2, 3])

    @effects[:might].push([2, 11])
    @effects[:might].push([3, 9])
    @effects[:might].push([4, 7])

    @effects[:mp].push([2, 12])

    @effects[:luck].push([1, 1])
  end

  context 'when updating effects timers' do
    before(:each) do
      Effects.update_effects_timers(@effects)
    end

    it { @effects[:ac].length.should == 1 }
    it { @effects[:ac][0][1].should == 1 }

    it { @effects[:hp].length.should == 1 }
    it { @effects[:hp][0][1].should == 2 }

    it { @effects[:might].length.should == 3 }
    it { @effects[:might][0][1].should == 10 }
    it { @effects[:might][1][1].should == 8 }
    it { @effects[:might][2][1].should == 6 }

    it { @effects[:mp].length.should == 1 }
    it { @effects[:mp][0][1].should == 11 }

    it { @effects[:luck].length.should == 0 }

    context 'when updating effects timers a second time' do
      before(:each) do
        Effects.update_effects_timers(@effects)
      end

      it { @effects[:ac].length.should == 0 }

      it { @effects[:hp].length.should == 1 }
      it { @effects[:hp][0][1].should == 1 }

      it { @effects[:might].length.should == 3 }
      it { @effects[:might][0][1].should == 9 }
      it { @effects[:might][1][1].should == 7 }
      it { @effects[:might][2][1].should == 5 }

      it { @effects[:mp].length.should == 1 }
      it { @effects[:mp][0][1].should == 10 }

      it { @effects[:luck].length.should == 0 }
    end
  end
end