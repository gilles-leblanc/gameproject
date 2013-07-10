require_relative '../actions'
require_relative '../character_test_data_builder'

describe "Actions" do
  before(:each) do
    character_builder = CharacterTestDataBuilder.new
    @character = character_builder.build
  end

  context "when blocking" do
    before(:each) do
      @base_ac = @character.ac
      @character.block
    end

    it { @character.ac.should == @base_ac + 2 }
    it { @character.effects[:ac].length.should == 1 }
    it { @character.effects[:ac][1] == 1 }

    context "when adding another ac effect" do
      before(:each) do
        @character.effects[:ac].push([3, 1])
      end

      it { @character.ac.should == @base_ac + 5 }
    end
  end
end
