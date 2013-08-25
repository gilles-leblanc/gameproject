require_relative '../treasure_table'

describe 'Treasure table' do
  context 'Items' do
    before(:each) do
      @treasure_table = TreasureTable.new
    end

    it { @treasure_table.one_item.should_not be_nil }
  end
end
