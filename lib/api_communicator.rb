require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character)
  answer = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters = character_hash["results"]

    name = characters.find {|person| person["name"].downcase == character}
    movies = name["films"]

    movies.each do |movie|
    raw = RestClient.get(movie)
    answer.push(JSON.parse(raw))
  end
  answer
  end


def parse_character_movies(films_hash)
  films_hash.each.with_index do |movie_stuff, index|
    puts "#{index +1}. #{movie_stuff["title"]}"
    puts "Episode #{movie_stuff["episode_id"]}"
    puts "Directed by #{movie_stuff["director"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

show_character_movies("luke skywalker")
