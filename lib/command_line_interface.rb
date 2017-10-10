require 'pry'

def welcome
  puts "Hello!"
end

def get_character_from_user
  puts "please enter a character"
  result = gets.chomp.downcase
  result = result.split(" ").map {|word| word.capitalize}.join(" ")
  binding.pry

  show_character_movies(result)
  # use gets to capture the user's input. This method should return that input, downcased.
end

get_character_from_user
