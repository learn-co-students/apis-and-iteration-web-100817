def welcome
  # puts out a welcome message here!
  puts "Hello there! Welcome to our friendly program."
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp.downcase
end
