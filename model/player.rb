class Player

  attr_accessor :id, :name, :kills

  def initialize(id, name)
    @id = id
    @name = name
    @kills = 0
  end  

  def add_kill
    kills = kills + 1 
  end

  def remove_kill
    kills = kills - 1 
  end

end