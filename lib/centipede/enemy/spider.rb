class Enemy::Spider < Enemy

  attr_accessor :jumping, :standing, :landing
  
  def initialize(window, x, y)
    self.jumping, self.standing, self.landing = Gosu::Image.load_tiles(window, "images/spider.png", 15, 8, false)
    @current_sprite = jumping
    @wait = 0
    super
  end
  
  def update
    @wait += 1
  end
  
  def draw
    animate
  end

  def animate
    if @wait > 10
      @wait = 0
      @current_sprite = next_sprite
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
end