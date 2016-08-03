class Parserlog

  require 'json'

  def read_log

    file = File.open('games.log', 'r')
    count_game = 0
    new_game = true
    games = [] 
    game = {}

    file.each_line do |line|
      if line.include?('InitGame')
        new_game = true

        puts "inicio" # retirar depois
        if count_game > 0  
          for p in game.players
            puts p.id 
            puts p.name
            puts p.kills
          end
        end   
        puts "fim" # retirar depois

        count_game = count_game + 1
        game = Game.new(count_game) # criando game com id 
        games << game
      elsif line.include?('ClientUserinfoChanged')
        extract_player_config(line, game)
      elsif line.include?('Kill')
        extract_kill_line(line, game)
      end
      new_game = false  
    end 
    file.close
  end 


  def extract_kill_line(line, game)
    kill_dados = line.split("Kill: ")
    assassino = kill_dados[1].split(" ")[0]
    assassinado = kill_dados[1].split(" ")[1]

    if assassino == "1022"
      for play in game.players
        if play.id == assassinado
          play.kills = play.kills - 1
        end  
      end  
    else
      for play in game.players
        if play.id == assassino
          play.kills = play.kills + 1
        end
      end  
    end  
  end
    
  def extract_player_config(line, game)
    config_user = line.split("ClientUserinfoChanged: ")
    id = config_user[1].split(" ")[0]
    name = config_user[1].split('\\')[1]
    player = Player.new(id, name)
    game.add_player(player)
  end   

  # game_1: {
  #   total_kills: 45;
  #   players: ["Dono da bola", "Isgalamido", "Zeh"]
  #   kills: {
  #     "Dono da bola": 5,
  #     "Isgalamido": 18,
  #     "Zeh": 20
  #   }
  # }

  def format_json_game(games)
    kills = []
    kil = {}
    #puts line

    my_object = { 
      :total_kills => "3",
      :players => ["Dono da bola", "Isgalamido", "Zeh"],
      :kills => "hashhhh"
    }
    puts JSON.pretty_generate(my_object)
  end 

end  


