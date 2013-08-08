require 'yaml'

# load the input data from a file containing a plain text sample data of names separated by spaces
class FileInputLoader
  # @param [Object] input filename containing plain text sample data of names.
  def load(input)
    begin
      IO.read(input).downcase
    rescue Errno::ENOENT => e
      puts e.inspect
      puts "Input fully qualified filename : #{Dir.pwd}#{input}"
      raise e
    end
  end
end

# load the input data from a string or array in memory which is passed as a parameter to load
class MemoryInputLoader
  # @param [Object] input string or array in memory containing sample names data.
  def load(input)
    input.downcase
  end
end

# load the input data from a file which contains the already calculated frequencies serialized to YAML
class YAMLInputLoader
  # @param [Object] input file containing a hash of frequencies serialized to YAML.
  def load(input)
    YAML.load_file(input)
  end
end