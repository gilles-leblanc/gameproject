require_relative '../spells/spells'
require_relative '../sorcerer'
require_relative '../character_test_data_builder'

describe 'Spells' do
  context 'Character\'s spell list' do
    before(:each) do
      @sorcerer = CharacterTestDataBuilder.new.build_sorcerer
    end

    it { @sorcerer.should respond_to :spells }
    it { @sorcerer.spells.should be_a(Hash) }

    context 'Accessing spells' do
      before(:each) do
        @sorcerer.spells[1].push(FlameArrow.new)
        @sorcerer.spells[1].push(MagicShield.new)
      end

      it { @sorcerer.spells[1].count.should == 2 }
      it { @sorcerer.spells[1][0].name.should == 'Flame Arrow' }
      it { @sorcerer.spells[1][0].should respond_to :cast }
    end

    context 'Outputting a character\'s spells' do
      before(:each) do
        @sorcerer.spells[1].push(FlameArrow.new)
        @sorcerer.spells[1].push(Spell.new('Magic Missile'))
        @sorcerer.spells[1].push(Spell.new('Light'))
        @sorcerer.spells[2].push(Spell.new('Aerial Servant'))
        @sorcerer.spells[2].push(Spell.new('Darkness'))
        @sorcerer.spells[2].push(Spell.new('Might'))
        @sorcerer.spells[3].push(Spell.new('Confusion'))
        @sorcerer.spells[3].push(Spell.new('Fireball'))
        @sorcerer.spells[4].push(Spell.new('Wall of Ice'))
        @sorcerer.spells[5].push(Spell.new('Wish'))
      end

      it 'should output spells correctly' do
        @sorcerer.spells.to_s.should == "[1:1]-Flame Arrow [1:2]-Magic Missile [1:3]-Light 
[2:1]-Aerial Servant [2:2]-Darkness [2:3]-Might 
[3:1]-Confusion [3:2]-Fireball 
[4:1]-Wall of Ice 
[5:1]-Wish 
"
      end
    end
  end
end
