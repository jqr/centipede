class Enemy::Spider < Enemy

  attr_accessor :jumping, :standing, :landing
  
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
    @current_sprite.draw(x, y, 0, 2, 2)
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
<<<<<<< HEAD:lib/centipede/enemy/spider.rb
end
=======
  
  def move!
    self.x = rand(@window.width)
    self.y = y + 20
  end
end
>>>>>>> Simple movement for the spider.:lib/centipede/enemy/spider.rb
