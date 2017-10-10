def welcome
  puts "Hi! Welcome to Star Wars IMDB. What character would you like to see?"
end

def get_character_from_user
  puts "Please enter a character"
  character = gets.chomp
  return character.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
