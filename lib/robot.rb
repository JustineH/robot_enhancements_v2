class Robot

  class RobotAlreadyDeadError < StandardError; end
  class UnattackableEnemy < StandardError; end

  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  WEAK_DEFAULT_ATTACK = 5

  attr_reader :position, :items, :items_weight, :health 
  attr_accessor :equipped_weapon


  def initialize
    @position = [0, 0]
    @items = []
    @items_weight = 0
    @health = MAX_HEALTH
    @equipped_weapon = nil
  end

  def move_left
    position[0] -= 1
  end

  def move_right
    position[0] += 1
  end

  def move_up
    position[1] += 1
  end

  def move_down
    position[1] -= 1
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      @equipped_weapon = item
    end
    if item.is_a?(BoxOfBolts) && health <= 80 
      item.feed(self)
    end
      items << item if items_weight + item.weight <= MAX_WEIGHT
  end

  def items_weight
    items.reduce(0) { |sum, item| sum + item.weight }
  end

  def wound(damage)
    @health -= damage
    @health = 0 if health < 0
  end

  def heal(amount)
    @health += amount
    @health = MAX_HEALTH if health > MAX_HEALTH
  end

  def attack(enemy)
    if @equipped_weapon.is_a?(Grenade) && attack_within_range?(enemy, 2)
      equipped_weapon.hit(enemy)
      @equipped_weapon = nil
    elsif attack_within_range?(enemy)
      if equipped_weapon
        equipped_weapon.hit(enemy)
      else
        enemy.wound(WEAK_DEFAULT_ATTACK)
      end
    end
  end

  def attack_within_range?(enemy, range=1)
    (position[0] == enemy.position[0] && (position[1] - enemy.position[1]).abs <= range) || (position[1] == enemy.position[1] && (position[0] - enemy.position[0]).abs <= range)
  end

  def heal!(amount)
    raise RobotAlreadyDeadError if health <= 0
    heal(amount)
  end

  def attack!(enemy)
    raise UnattackableEnemy unless enemy.is_a?(Robot)
    attack(enemy)
  end

end

