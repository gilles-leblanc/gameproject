require_relative '../treasure_table'

describe 'Treasure table' do
  context 'Items' do
    before(:each) do
      @treasures = TreasureTable.new
    end

    it { @treasures.one_item.should_not be_nil }
    it { TreasureTable.none.should eq [] }
    it { (TreasureTable.small_amount_of_gold + @treasures.one_item).length.should eq 2 }
  end
end
