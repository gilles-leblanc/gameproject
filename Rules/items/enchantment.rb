class Enchantment
  attr_accessor :name, :value

protected

  def self.null_object
    null_object_enchantment = Enchantment.new
    null_object_enchantment.name = ""
    null_object_enchantment.value = 0

    null_object_enchantment
  end
end