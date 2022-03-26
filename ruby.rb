require 'yaml'

class Test
  attr_accessor :name, :age, :sign
  def initialize
    @name = "harry"
    @age = "18"
    @sign = "gryffindor"
  end

  # Uses file.exist to see if directory exists, if not, creates directory
  # uses file.open to create new file in "write"
  # YAML.dump stores a hash of desired values to serialize 
  def to_yaml
    Dir.mkdir('saved_games') unless File.exist?('saved_games')
    f = File.open('saved_games/second_yaml.yml', 'w')
    YAML.dump({
      :name => @name,
      :age => @age,
      :sign => @sign
    }, f)
    f.close
  end

  # use YAML.load converts a YAML file to ruby object
  # File.read opens and reads the saved YAML file
  # In this case the existing class instance variables are set to YAML values
  # you could also create a new class instance by passing values into class.new as parameters
  def from_yaml
    f = YAML.load(File.read('./saved_games/second_yaml.yml'))
    @name = f[:name]
    @age = f[:age]
    @sign = f[:sign]
  end

end

ben = Test.new
puts ben.name
puts ben.age
puts ben.sign
# ben.to_yaml   # uncomment to make yaml

# manually change name sign and age
ben.from_yaml
puts ben.name
puts ben.age
puts ben.sign
# name sign and age should be back to original
