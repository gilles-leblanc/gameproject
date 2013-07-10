require_relative '../items/armors'
require_relative '../items/enchantment'
require_relative '../character_test_data_builder'

describe "Enchantments" do
  before(:each) do
    character_builder = CharacterTestDataBuilder.new
    @character = character_builder.build

    @armor = PaddedArmor.new
    @character.paper_doll.equip(@armor)
  end

  it { @character.ac.should == 2 }

  context "with material enchantment grass" do
    before(:each) do
      @armor.material_enchantment = Grass.new
    end

    # a material enchantment should not bring the values below 0
    it { @character.ac.should == 0 }
  end

  context "with material enchantment bronze" do
    before(:each) do
      @armor.material_enchantment = Bronze.new
    end

    it { @character.ac.should == 2 }
  end

  context "with material enchantment steel" do
    before(:each) do
      @armor.material_enchantment = Steel.new
    end

    it { @character.ac.should == 4 }
  end
end
