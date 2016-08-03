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