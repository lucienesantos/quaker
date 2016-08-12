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

  def players_formated
    players.map { |player| player.name }    
  end 

  def kills_by_player
    kills = {}
    players.each { |player| kills[player.name] = player.kills }
    return kills
  end 

  def add(player)
    players << player
  end  

  def update(player)
    players.find { |p| p.id == player.id }.name  = player.name
  end

  def exists(player)
    players.select { |p| p.id.eql? player.id }.any?
  end  

end