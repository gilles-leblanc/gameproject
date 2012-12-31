class FileInputLoader
  def load(input)
    IO.read(input).downcase
  end
end

class MemoryInputLoader
  def load(input)
    input.downcase
  end
end