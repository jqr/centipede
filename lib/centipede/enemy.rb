class Enemy
  
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
    Game.current_game.remove(self)
  end
  
  def grid_x
    x / @window.game.level.tile_size
  end
  
  def grid_y
    y / @window.game.level.tile_size
  end

end
