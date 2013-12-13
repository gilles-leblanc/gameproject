# A simple module to output text. Was intended to be used to easily replace
# puts with something that plugs in the UI at a latter date. Wondering if
# truly useful ???
module Broadcast
  def broadcast(message)
    puts message
  end
end
