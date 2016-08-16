require 'json'
require File.expand_path('model/kill.rb')
require File.expand_path('model/game.rb')
require File.expand_path('model/player.rb')
require File.expand_path('parserlog.rb')

 
 b = Parserlog.new
 b.print_games('games.log')
 b.print_rank_geral('games.log')
 b.print_means_of_death('games.log')

