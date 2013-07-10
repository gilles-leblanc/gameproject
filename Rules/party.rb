class Party
  attr_accessor :gold
  attr_reader :members

  def initialize
    @members = Array.new
  end
end
