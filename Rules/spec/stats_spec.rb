require_relative '../stats'
require_relative '../races'

describe 'Stats' do
  before(:each) do
    @stats = Stats.new
    @stats.might = 18
    @stats.accuracy = 17
    @stats.endurance = 14
    @stats.intellect = 8
    @stats.personality = 7
    @stats.speed = 13
    @stats.luck = 10
  end

  specify { @stats.might_modifier.should == 4 }
  specify { @stats.accuracy_modifier.should == 3 }
  specify { @stats.endurance_modifier.should == 2 }
  specify { @stats.intellect_modifier.should == -1 }
  specify { @stats.personality_modifier.should == -2 }
  specify { @stats.speed_modifier.should == 1 }
  specify { @stats.luck_modifier.should == 0 }
end
