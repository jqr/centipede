class Enemy::Spider < Enemy

  attr_accessor :jumping, :standing, :landing
  
  has_score 300
  
  def initialize(window)
    super(window, x, y)
    start_position!(window)
    self.jumping, self.standing, self.landing = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'spider.png'), 15, 8, false)
    @current_sprite = standing
    @wait = 0
    @window.play_sound('spider')
  end
  
  def start_position!(window)
    self.x, self.y = rand(window.width), 0
  end
  
  def update(time)
    @wait += 1
  end
  
  def draw
    animate
  end
  
  def animate
    if @wait > 30
      @wait = 0
      @current_sprite = next_sprite
      move!
    end
    @current_sprite.draw(x, y, Z_ORDER, 2, 2)
  end 
  
  def next_sprite
    @current_sprite = 
      case @current_sprite
        when jumping
          landing
        when standing
          jumping
        when landing
          standing
        else 
          jumping
      end
  end
  
  def move!
    self.x = rand(@window.width)
    self.y = y + 20
  end
end
