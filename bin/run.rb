#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character=nil
results=get_character_movies_from_api(character)
until results.include?(character)
  character=get_character_from_user
end

show_character_movies(character)
