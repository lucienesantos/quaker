class Player

  attr_accessor :id, :name, :kills

  def initialize(id, name)
    @id = id
    @name = name
    @kills = 0
  end  

  def add_kill
    @kills = @kills + 1 
  end

  def remove_kill
    @kills = @kills - 1 
  end

  # def total_kills(games)
  #   for game in games
  #     if 
  #   end
  # end  

  def exists(player, list)
    if !list.nil? and list.size > 0
      list.select { |p|
        if p.id.eql? player.id
          return true
        end 
      }
      return false 
    else
      return false 
    end  
  end  

  def exists_by_name(player, list)
    if !list.nil? and list.size > 0
      list.select { |p|
        if p.name.eql? player.name
          return true
        end 
      }
      return false 
    else
      return false 
    end  
  end  

end