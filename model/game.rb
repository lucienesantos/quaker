class Game

  attr_accessor :id, :players
  

  def initialize(id)
    @id = id
    @players = []
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
    for play in players
      total_kills += play.kills
    end  
    return total_kills
  end  

  def get_players
    players_formated = []
    for play in players
      players_formated << play.name
    end  
    return players_formated
  end 

# kills: {
#       "Dono da bola": 5,
#       "Isgalamido": 18,
#       "Zeh": 20
#     }
  def get_kills_by_player
    kills = {}
    for play in players
      kills[play.name] = play.kills
    end
    return kills
  end 

  def add(player)
    players << player
  end  

  def update(player)
    for p in players
      if p.id == player.id
        p.name = player.name
      end 
    end
  end

  def exists(player)
    if players.size > 0
      for p in players
        if p.id.eql? player.id
          return true
        end 
      end
      return false 
    else
      return false 
    end
  end  

end