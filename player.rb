class Player
  def play_turn(warrior)
    @health ||= 20
    
    if warrior.feel.wall?
      warrior.pivot!
    else
      if warrior.feel(:backward).enemy?
        warrior.pivot!
      elsif rescue_captives(warrior)
      elsif heal_or_retreat(warrior)
      elsif attack_enemy(warrior)
      else
        warrior.walk!

      end
    end
    @health = warrior.health
  end
  
  def rescue_captives(warrior)
    # rescue captives, if there are any in a space next to warrior
    if warrior.look[0].captive?
        warrior.rescue! 
        @hero=true
    elsif warrior.feel(:backward).captive?
        warrior.rescue! :backward
        @hero=true
    end
  end
  
  def heal_or_retreat(warrior)
    if warrior.feel.empty?
      if warrior.health < 20 and warrior.health >= @health 
        warrior.rest!
      elsif warrior.health < 15 and warrior.health < @health 
        warrior.walk! :backward
      end
    end
  end
  
  def attack_enemy(warrior)
    if warrior.feel.enemy?
      warrior.attack!
    elsif enemy_position(warrior) < captive_position(warrior)
      warrior.shoot!
    end
  end
  
  def enemy_position(warrior)
    warrior.look.find_index {|space| space.enemy?} or 4
  end
  
  def captive_position(warrior)
    warrior.look.find_index {|space| space.captive?} or 4
  end
  
end
