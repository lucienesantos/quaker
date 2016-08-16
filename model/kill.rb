class Kill

  attr_accessor :id, :killed_id, :killer_id, :means

  def initialize(killed_id, killer_id, means)
    @killed_id = killed_id
    @killer_id = killer_id
    @means = means
    
  end
    
  def self.means_of_death
   return [
      "MOD_UNKNOWN",
      "MOD_SHOTGUN",
      "MOD_GAUNTLET",
      "MOD_MACHINEGUN",
      "MOD_GRENADE",
      "MOD_GRENADE_SPLASH",
      "MOD_ROCKET",
      "MOD_ROCKET_SPLASH",
      "MOD_PLASMA",
      "MOD_PLASMA_SPLASH",
      "MOD_RAILGUN",
      "MOD_LIGHTNING",
      "MOD_BFG",
      "MOD_BFG_SPLASH",
      "MOD_WATER",
      "MOD_SLIME",
      "MOD_LAVA",
      "MOD_CRUSH",
      "MOD_TELEFRAG",
      "MOD_FALLING",
      "MOD_SUICIDE",
      "MOD_TARGET_LASER",
      "MOD_TRIGGER_HURT",
      "MOD_NAIL",
      "MOD_CHAINGUN",
      "MOD_PROXIMITY_MINE",
      "MOD_KAMIKAZE",
      "MOD_JUICED",
    ]
  end  

end
