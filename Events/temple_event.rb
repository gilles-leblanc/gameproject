require_relative '../broadcast'

class TempleEvent
  include Broadcast

  def initialize(templeName)
    templeName = templeName
  end

  def act
    broadcast "Temple: Welcome to #{templeName}."

  end
end