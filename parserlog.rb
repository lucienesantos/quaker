class Parserlog

  def read_log
    file = File.open('games.log', 'r')
    count_game = 0
    new_game = true
    game = {}
    games = []

    file.each_line do |line|
      if line.include?('InitGame')
        new_game = true
        count_game += 1
        game = Game.new(count_game) 
        games << game
      elsif line.include?('ClientUserinfoChanged')
        extract_player_config(line, game)
      elsif line.include?('Kill')
        extract_kill_line(line, game)
      end
      new_game = false  
    end 
    file.close
    return games
  end 

  def print_games
    games = read_log
    puts format_json_games(games)
  end 

  # def print_rank_geral
  #   games = read_log
  #   puts games
  #   players_ranking = []
  #   for game in games
  #     calcula_kills(players_ranking, game)
  #   end 
  #    puts players_ranking
  # end

  # def calcula_kills(players_ranking, game)
  #   for play in game.players

       
  #   end

  # end 



  def extract_kill_line(line, game)
    kill_dados = line.split("Kill: ")
    cod_killer = kill_dados[1].split(" ")[0]
    cod_killed = kill_dados[1].split(" ")[1]
    game.process_kill(cod_killer, cod_killed, game)
  end
    
  def process_player(id, name, game)
    player = Player.new(id, name)
    game.add_player(player)
  end   

  def extract_player_config(line, game)
    user = line.split("ClientUserinfoChanged: ")
    id = user[1].split(" ")[0]
    name = user[1].split('\\')[1]
    process_player(id, name, game)
  end   

  def format_json_games(games)
    games_objs = {}
    for game in games
      game_obj = { 
        :total_kills => game.total_kills,
        :players => game.get_players,
        kills: game.get_kills_by_player 
      }
      games_objs["game_ #{game.id}"] = game_obj
    end
    return JSON.pretty_generate(games_objs)
  end 

end  


