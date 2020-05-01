class Dog
  attr_accessor :name, :id
  attr_reader :breed
  def initialize(id=nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
end
