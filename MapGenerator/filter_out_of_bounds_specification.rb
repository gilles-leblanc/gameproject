class FilterOutOfBoundsSpecification
  def self.satisfied_by?(z, size_z, offset)
    return true if z + offset >= size_z

    return true if z + offset < 0

    false
  end
end
