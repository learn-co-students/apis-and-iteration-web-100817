def welcome
  "Welcome to Star Wars info session"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.downcase.chomp
end
