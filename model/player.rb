class Player

  attr_accessor :id, :name, :kills, :kills_valids

  def initialize(id, name)
    @id = id
    @name = name
    @kills = []
    @kills_valids  = 0
  end  

  def add_kill_valids
    @kills_valids = @kills_valids + 1 
  end

  def remove_kill_valids
    @kills_valids = @kills_valids - 1 
  end
 
  def exists_by_name(player, list)
    list.select { |p| p.id.eql? player.id }.any?
  end 

end