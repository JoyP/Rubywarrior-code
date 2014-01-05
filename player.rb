class Player
  def play_turn(warrior)
    # cool code goes here
    @health ||= 20
    if attr_writer :arrior.feel.captive?
      warrior.rescue!
      @hero=true
    elsif warrior.feel(:backward).captive?
      warrior.rescue! :backward
      @hero=true
    elsif warrior.feel.empty? and warrior.health < 20 and warrior.health >= @health
      warrior.rest!
    elsif warrior.feel.empty? and warrior.health < 15 and warrior.health < @health
      warrior.walk! :backward
    elsif warrior.feel.empty?
      if @hero
        warrior.walk!
      else
        warrior.walk! :backward
      end
    else
      warrior.attack!
    end
    @health = warrior.health
  end
end
