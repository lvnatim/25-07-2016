A lot of the time, in Ruby, we deal with instances of an object. That instance will have it's own methods
and it's own properties, which we can tinker and toy with. Sometimes, however, we want to meddle with the
class or object that the instance belongs to. In the scope of wherever we call the 'self' keyword, we pull the object that houses that scope. 

If we have a class, let's say:

Class Person

  def print_class
    puts self.class
  end

  def self.print_class
    puts self.class
  end

end


By putting self in front of the print_class method, we are defining a method for calls to the Class instance (which is a Person class). It's all quite confusing, but these two methods would return different things. The print_class method, without the self, would be a method definition for an Person instance.

The print_class, when called by a Person instance, would return Person.

The self.print_class, when called by the Class instance, would return Class.

Of course, calling the methods would also look syntatically different. To call the print_class from an instance,
we would first have to instantiate a Person object. For self.print_class, we can call directly from the Person class.

First example (calling from instance of Person class):

person = Person.new
person.print_class
# returns Person

Second example (calling from Person class):

Person.print_class
# returns Class