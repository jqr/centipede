class Enemy
  Z_ORDER = 1
  
  attr_accessor :x, :y, :image

  class << self
    def has_score(num)
      @score = num
    end

    def score
      @score
    end
  end

  def initialize(window, x, y)
    @window = window
    self.x = x
    self.y = y
  end
  
  def update(time)
  end
  
  def draw    
  end

  def die
    Game.current_game.score += self.class.score
    destroy
  end
  
  def grid_x
    x / Game.current_game.level.tile_size
  end
  
  def grid_y
    y / Game.current_game.level.tile_size
  end
  
  def collides_with?(x, y)
    (self.x..(self.x + sprite.width * 2)).include?(x) && (self.y..(self.y + sprite.height * 2)).include?(y)
  end

  def hit
    destroy
  end

  def destroy
    Game.current_game.remove(self)    
  end

end
