require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_hash = []

  character_hash["results"].map do |character_info| #iterating through array
=begin THIS WAS OUR FIRST ATTEMPT AT ACCESS ADDITIONAL PAGES
    until character_info["name"].downcase == character
      url = character_hash["next"]
      all_characters = RestClient.get(url)
      character_hash = JSON.parse(all_characters)
    end
=end

    if character_info["name"].downcase == character
        character_info["films"].map do |film|
          character_films = RestClient.get(film)
          film_info = JSON.parse(character_films)
          films_hash << film_info
        end
    end
  end
  films_hash
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.



def show_character_movies(character_argument)
  film_results = get_character_movies_from_api(character_argument)
  parse_character_movies(film_results)
end


def parse_character_movies(films_hash_argument)
 films_hash_argument.each.with_index do |film, index|
   puts "#{index+1}. #{film["title"]}"
 end
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
#
#def get_character_film_hash

#end
