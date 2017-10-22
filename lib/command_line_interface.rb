def welcome
  # puts out a welcome message here!
  puts "Hello there! Welcome to our friendly program."
end

def run_program
  case get_user_choice
  when "1"
    character = get_character_from_user
    show_character_movies(character)
  when "2"
    movie = get_movie_from_user
    show_movie_details(movie)
  else
    puts "Invalid input. Please try again."
    get_user_choice
  end
end

def get_user_choice
  puts "What would you like to do? Enter 1 to search a character, enter 2 to search a movie :)"
  response = gets.chomp
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase
end

def get_movie_from_user
  puts "please enter a movie"
  gets.chomp.downcase
end