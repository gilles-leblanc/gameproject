require_relative '../character'
require_relative '../stats'
require_relative '../races'

describe 'character class' do
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

  context 'when applying racial bonuses' do
    context 'when race is human' do
      before(:each) do
        race = Human.new
        @character = Character.new('Felgar', race, @stats)
      end

      specify { @character.stats.might == 18 }
      specify { @character.stats.accuracy == 17 }
      specify { @character.stats.endurance == 14 }
      specify { @character.stats.intellect == 8 }
      specify { @character.stats.personality == 7 }
      specify { @character.stats.speed == 13 }
      specify { @character.stats.luck == 10 }
    end

    context 'when race is elf' do
      before(:each) do
        race = Elf.new
        @character = Character.new('Felgar', race, @stats)
      end

      specify { @character.stats.might == 17 }
      specify { @character.stats.accuracy == 18 }
      specify { @character.stats.endurance == 13 }
      specify { @character.stats.intellect == 9 }
      specify { @character.stats.personality == 7 }
      specify { @character.stats.speed == 13 }
      specify { @character.stats.luck == 10 }
    end
  end
end
