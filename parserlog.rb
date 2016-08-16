class Parserlog


  def print_games(file_path)
    puts "************************************** Task 01 ****************************************************"
    puts "***************************************************************************************************"
    games = read_log(file_path)
    puts format_json_games(games)
    puts "***************************************************************************************************"
  end 

  def print_rank_geral(file_path)
    puts "************************************** Task 02 ****************************************************"
    puts "***************************************************************************************************"
    kills_valids_players_total(file_path)
    kills_valids_players_by_game(file_path)
    puts "***************************************************************************************************"
  end

  def print_means_of_death(file_path)
    puts "************************************** Task 03 ****************************************************"
    puts "***************************************************************************************************"
    means_of_death_by_game(file_path)
    puts "***************************************************************************************************"
  end

  def means_of_death_by_game(file_path)
    games = read_log(file_path)
    games.select { |game|
      puts "GAME_#{game.id}"
      puts game.means_of_death_formated
    }
  end  

  def kills_valids_players_total(file_path)
    players_total = rank_geral(file_path)
    players_total.select { |player|
      puts  "PLAYER  #{player.name} #{player.kills_valids} KILLS"
    }
  end

  def kills_valids_players_by_game(file_path)
    games = read_log(file_path)
    games.select { |game|
      puts "GAME_#{game.id}"
      game.players.each { |player|
        puts  "PLAYER  #{player.name} #{player.kills_valids} KILLS"
      }
    }
  end 

  def rank_geral(file_path)
    games = read_log(file_path)
    players_ranking = []
    games.select { |game|
      game.players.select { |player|
        if player.exists_by_name(player, players_ranking)
          players_ranking.select { |p|
            if p.name == player.name
              p.kills_valids += player.kills_valids
            end  
          }
        else
          players_ranking << player
        end  
      }
    }
    return players_ranking
  end 

  def read_log(file_path)
    file = File.open(file_path, 'r')
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
    killer_id = kill_dados[1].split(" ")[0]
    killed_id = kill_dados[1].split(" ")[1]
    mean_of_death = kill_dados[1].split(" ")[2]
    game.process_kill(killer_id, killed_id, mean_of_death)

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
        :total_kills => game.total_kills_valids,
        :players => game.players_formated,
        kills: game.kills_valids_by_player 
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


