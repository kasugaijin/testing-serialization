require 'yaml'

class Test
  attr_accessor :name, :age, :sign, :wand
  def initialize
    @name = "ron"
    @age = "18"
    @sign = "toad"
    @wand = Wand.new
  end

  # Uses file.exist to see if directory exists, if not, creates directory
  # uses file.open to create new file in "write"
  # YAML.dump stores a hash of desired values to serialize 
  def to_yaml
    Dir.mkdir('saved_games') unless File.exist?('saved_games')
    f = File.open('saved_games/third_yaml.yml', 'w')
    YAML.dump({
      :name => @name,
      :age => @age,
      :sign => @sign, 
      :wand_length => @wand.length,
      :wand_name => @wand.name
    }, f)
    f.close
  end

  # use YAML.load converts a YAML file to ruby object
  # File.read opens and reads the saved YAML file
  # In this case the existing class instance variables are set to YAML values
  # you could also create a new class instance by passing values into class.new as parameters
  def from_yaml
    f = YAML.load(File.read('./saved_games/third_yaml.yml'))
    @name = f[:name]
    @age = f[:age]
    @sign = f[:sign]
    @wand.length = f[:wand_length]
    @wand.name = f[:wand_name]
  end

end

class Wand
attr_accessor :length, :name

  def initialize
    @length = 1000
    @name = "twiggy"
  end
end

ben = Test.new
puts ben.name
puts ben.age
puts ben.sign
puts ben.wand.length
puts ben.wand.name
# ben.to_yaml
ben.from_yaml
puts ben.name
puts ben.age
puts ben.sign
puts ben.wand.length
puts ben.wand.name

