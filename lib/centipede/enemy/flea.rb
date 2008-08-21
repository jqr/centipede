class Enemy::Flea < Enemy
  attr_accessor :x, :y

  has_score 200
  
  def initialize(window)
    super(window, x, y)
    start_position!(window)
    @current_sprite = Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'flea.png'))
    @wait = 0
    @window.play_sound('flea')
    @hits = 0
  end

  def start_position!(window)
    self.x, self.y = rand(window.width / 16) * 16, 0    
  end

  def update(time)
    self.y = y + 2 + 5 * @hits

    if off_screen?
      destroy 
    else
      if rand(7) == 1
        Game.current_game.level.grid[grid_y][grid_x] = 4
      end
    end
  end
  
  def off_screen?
    !Game.current_game.level.grid[grid_y]
  end
  
  def sprite
    @current_sprite
  end
  
  def draw
    @current_sprite.draw(x, y, 0, 2, 2)
  end
  
  def hit
    @hits += 1
    destroy if @hits == 2
  end
  

end
