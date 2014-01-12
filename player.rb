class Player
  attr_accessor :warrior
  
  def play_turn(warrior)
    self.warrior = warrior
    @health ||= 20
    
    if warrior.feel.wall?
      warrior.pivot!
      @feltwall = true
    else
      if warrior.feel(:backward).enemy?
        warrior.pivot!
      elsif rescue_captives
      elsif heal_or_retreat
      elsif attack_enemy
      else 
        walk_or_pivot
      end
    end
    @health = warrior.health
  end
  
  def rescue_captives
    # rescue captives, if there are any in a space next to warrior
    if warrior.look[0].captive?
        warrior.rescue! 
    elsif warrior.feel(:backward).captive?
        warrior.rescue! :backward
    end
  end
  
  def heal_or_retreat
    if warrior.feel.empty?
      if warrior.health < 20 and warrior.health >= @health 
        warrior.rest!
      elsif warrior.health < 15 and warrior.health < @health 
        warrior.walk! :backward
      end
    end
  end
  
  def attack_enemy
    if warrior.feel.enemy?
      warrior.attack!
    elsif enemy_position < captive_position
      warrior.shoot!
    end
  end
  
  def enemy_position
    warrior.look.find_index {|space| space.enemy?} or 4
  end
  
  def captive_position
    warrior.look.find_index {|space| space.captive?} or 4
  end
  
  def walk_or_pivot
    if warrior.feel.stairs? and !@feltwall
      warrior.pivot!
    else 
      warrior.walk!
    end
  end      
end

  
