class Game

  attr_accessor :id, :players
  COD_WORLD_KILLER = "1022"

  def initialize(id)
    @id = id
    @players = []
  end

  def process_kill(cod_killer, cod_killed)
    if cod_killer == COD_WORLD_KILLER
      self.players.select { |player| 
        if player.id == cod_killed
          player.kills = player.remove_kill
        end  
      }  
    else
      self.players.select { |player|
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
    players.inject(0){|total_kills, player|
      total_kills += player.kills
    }
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
  def kills_by_player
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
    players.select { |p| p.id.eql? player.id }.any?
  end  

end