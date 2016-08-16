class Game

  attr_accessor :id, :players
  COD_WORLD_KILLER = "1022"

  def initialize(id)
    @id = id
    @players = []
  end 

  def means_of_death_formated
    means = {}
    self.players.select { |p| 
      p.kills.map {|e| Kill.means_of_death[e.means.to_i] }
       .each { |k|
        if exists_means_by_name(k, means)
          means[k] = means[k] + 1
        else
           means[k] = 1
         end
      }
    }
    return means
  end

  def process_kill(killer_id, killed_id, mean_of_death)
    kill = Kill.new(killed_id, killer_id, mean_of_death)
    if killer_id == COD_WORLD_KILLER
      self.players.select { |player| 
        if player.id == killed_id
          player.kills << kill
          player.remove_kill_valids 
        end  
      }  
    else
      self.players.select { |player| 
        if player.id == killer_id
          player.kills << kill
          player.add_kill_valids
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

  def total_kills_valids
    players.inject(0){|total_kills, player|
      total_kills += player.kills_valids }
  end  

  def players_formated
    players.map { |player| player.name }    
  end 

  def kills_valids_by_player
    kills_valids = {}
    players.each { |player| kills_valids[player.name] = player.kills_valids }
    return kills_valids
  end 

  def add(player)
    players << player
  end  

  def update(player)
    players.find { |p| p.id == player.id }.name  = player.name
  end

  def exists_means_by_name(elemento, list)
    list.select { |p| p.eql? elemento }.any?
  end
  
  def exists(player)
    players.select { |p| p.id.eql? player.id }.any?
  end 

end