class Game

  attr_accessor :id, :players
  COD_WORLD_KILLER = "1022"

  def initialize(id)
    @id = id
    @players = []
  end

  def process_kill(cod_killer, cod_killed, game)
    if cod_killer == COD_WORLD_KILLER
      game.players.select { |player| 
        if player.id == cod_killed
          player.kills = player.remove_kill
        end  
      }  
    else
      game.players.select { |player|
        if player.id == cod_killer
          player.kills = player.add_kill
        end
      }
    end
  end 

  def add_player(player)
    if exists(player)
      update(player)
    else
      add(player)
    end
  end 

  def total_kills 
    total_kills = 0
    players.select { |player|
      total_kills += player.kills
    } 
    return total_kills
  end  

  def get_players
    players_formated = []
    players.select { |player|
      players_formated << player.name
    }  
    return players_formated
  end 

# kills: {
#       "Dono da bola": 5,
#       "Isgalamido": 18,
#       "Zeh": 20
#     }
  def get_kills_by_player
    kills = {}
    players.select { |player|
      kills[player.name] = player.kills
    }
    return kills
  end 

  def add(player)
    players << player
  end  

  def update(player)
    players.select { |p|
      if p.id == player.id
        p.name = player.name
      end 
    }
  end

  def exists(player)
    if players.size > 0
      players.select { |p|
        if p.id.eql? player.id
          return true
        end 
      }
      return false 
    else
      return false 
    end
  end  

end