# Exercise methods for Chapter 4

def string_shuffle(s)
  s.split('').shuffle.join
end

class String
  def shuffle
    self.split('').shuffle.join
  end
end

@person1 = { :first => "Jacob", :last => "Harding" }
@person2 = { :first => "Helga", :last => "Greenberg" }
@person3 = { :first => "Bonnie", :last => "Clyde" }

@param = { :mother => @person1, :father => @person2, :child => @person3 }