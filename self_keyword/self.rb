class Person

  def self.example_class_method
    puts "We're calling an example class method"
    puts "Self is not always defined. What is 'self' here? Let's see"
    p self
    puts "That was self!"
  end

  def example_class_method
    puts "We're calling an example instance method"
    puts "Self is defined here, too, but it means something different"
    p self
    puts "That was self, but see how it was an instance of the class?"
  end

  puts "You'll see this as the class being defined"
  puts "In this context, self is:"
  p self
  puts "See? Self is the Person class."


end

Person.example_class_method
Person.new.example_class_method