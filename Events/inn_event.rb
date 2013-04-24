require_relative '../broadcast'

class InnEvent
  include Broadcast

  def initialize(innName)
    innName = innName
  end

  def act
    broadcast "Inn: Welcome to #{innName}."

  end
end