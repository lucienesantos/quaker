class Parserlog


  def print_games
    puts "************************************** Task 01 ****************************************************"
    puts "***************************************************************************************************"
    games = read_log
    puts format_json_games(games)
    puts "***************************************************************************************************"
  end 

  def print_rank_geral
    puts "************************************** Task 02 ****************************************************"
    puts "***************************************************************************************************"
    kills_players_total
    kills_players_by_game
    puts "***************************************************************************************************"
  end

  def kills_players_total
    players_total = rank_geral
    players_total.select { |player|
      puts  "PLAYER  #{player.name} #{player.kills} KILLS"
    }
  end

  def kills_players_by_game
    games = read_log
    games.select { |game|
      puts "GAME_#{game.id}"
      game.players.each { |player|
        puts  "PLAYER  #{player.name} #{player.kills} KILLS"
      }
    }
  end 

  def rank_geral
    games = read_log
    players_ranking = []
    games.select { |game|
      game.players.select { |player|
        if player.exists_by_name(player, players_ranking)
          players_ranking.select { |p|
            if p.name == player.name
              p.kills += player.kills
            end  
          }
        else
          players_ranking << player
        end  
      }
    }
    return players_ranking
  end 

  def read_log
    file = File.open('games.log', 'r')
    game = {}
    games = []

    file.each_line do |line|
      if line.include?('InitGame')
        game = Game.new(games.size) 
        games << game
      elsif line.include?('ClientUserinfoChanged')
        extract_player_config(line, game)
      elsif line.include?('Kill')
        extract_kill_line(line, game)
      end
    end 
    file.close
    return games
  end

  def extract_kill_line(line, game)
    kill_dados = line.split("Kill: ")
    cod_killer = kill_dados[1].split(" ")[0]
    cod_killed = kill_dados[1].split(" ")[1]
    game.process_kill(cod_killer, cod_killed)
  end

  def extract_player_config(line, game)
    user = line.split("ClientUserinfoChanged: ")
    id = user[1].split(" ")[0]
    name = user[1].split('\\')[1]
    process_player(id, name, game)
  end   

  def format_json_games(games)
    games_objs = {}
    games.each { |game|
      game_obj = { 
        :total_kills => game.total_kills,
        :players => game.players_formated,
        kills: game.kills_by_player 
      }
      games_objs["game_ #{game.id}"] = game_obj
    }
    return JSON.pretty_generate(games_objs)
  end 
    
  def process_player(id, name, game)
    player = Player.new(id, name)
    game.add_player(player)
  end

end  


