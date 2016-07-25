#Animal, Mammal, Amphibian, Primate, Frog, Bat, Bird, Parrot, and Chimpanzee.
module Fly
  def fly
    return "I'm a #{self.name} and I'm flying!"
  end
end

class Animal
  attr_reader :name, :blood, :wings, :num_legs

  def initialize(name, blood, wings, num_legs)
    @name = name
    @blood = blood
    @wings = wings
    @num_legs = num_legs
  end

  def warm_blooded?
    blood == :warm ? true : false
  end

  def name
    @name.downcase
  end

end

class Mammal < Animal
  def initialize(name, wings, num_legs)
    super(name, :warm, wings, num_legs)
  end
end

class Amphibian < Animal
  def initialize(name, num_legs)
    super(name, :cold, 0, num_legs)
  end
end

class Primate < Mammal
  def initialize(name)
    super(name, 0, 2)
  end
end

class Frog < Amphibian
  def initialize
    super("Frog", 4)
  end
end

class Bat < Mammal
  include Fly
  def initialize
    super("Bat", 2, 0)
  end
end

class Bird < Animal
  include Fly
  def initialize(name)
    super(name, :warm, 2, 2)
  end
end

class Parrot < Bird
  def initialize
    super("Parrot")
  end
end

class Chimpanzee < Primate
  def initialize
    super("Chimpanzee")
  end
end

chimp = Chimpanzee.new
puts chimp.warm_blooded?
puts chimp.num_legs
puts chimp.name
puts chimp.wings


polly = Parrot.new
puts polly.fly

bat = Bat.new
puts bat.fly