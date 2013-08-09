# The group of player controlled characters and their communal assets.
class Party
  attr_accessor :gold
  attr_reader :members

  def initialize
    @members = []
  end
end
