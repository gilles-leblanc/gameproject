require_relative '../items/enchantment'
require_relative '../character_test_data_builder'
require_relative '../items/armors'

describe 'armors specs' do
  before(:each) do
    character_builder = CharacterTestDataBuilder.new
    @character =
        character_builder.with_armor_categories([:very_light, :light, :medium, :heavy]).build
  end

  it { @character.ac.should == 0 }

  context 'when equiping chain mail' do
    before(:each) do
      @character.paper_doll.equip(ChainMail.new)
    end

    it { @character.ac.should == 4 }
  end

  context 'when equiping plate mail' do
    before(:each) do
      @character.paper_doll.equip(PlateMail.new)
    end

    it { @character.ac.should == 6 }
  end
end
