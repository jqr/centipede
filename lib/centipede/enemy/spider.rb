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
    @last_x_direction = []
    @last_y_direction = []
  end
  
  def start_position!(window)
    self.x, self.y = 0, window.height - rand(150)
  end
  
  def update(time)
    @wait += 1
  end
  
  def draw
    animate
  end
  
  def animate
    if @wait > 4
      @wait = 0
      move!
      next_sprite
    end
    @current_sprite.draw(x, y, Z_ORDER, 2, 2)
  end
  
  def sprite
    @current_sprite
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
    self.x = 
      case x_direction
        when :left
          @last_x_direction << :left
          x - rand(10)
        when :right
          @last_x_direction << :right
          x + rand(10)
      end
    
    self.y =
      case y_direction
        when :up
          @last_y_direction << :up
          y - rand(10)
        when :down
          @last_y_direction << :down
          y + rand(10)
      end
  end
  
  def y_direction
    if y <= @window.height - 150
      :down
    elsif y >= @window.height - 30
      :up
    else
      if @last_y_direction.empty?
        [:up, :down][rand(2)]                         
      else
        if @last_y_direction.size == rand(5) + 2
          [:up, :down].reject do |direction|
            @last_y_direction.last == direction
          end.first               
        else
          @last_y_direction.last
        end
      end
    end
  end
  
  def x_direction
    if x <= 30
      :right
    elsif x >= @window.width - 30
      :left
    else
      if @last_x_direction.empty?
        [:left, :right][rand(2)]                         
      else
        if @last_x_direction.size == rand(5) + 2
          [:left, :right].reject do |direction|
            @last_x_direction.last == direction
          end.first               
        else
          @last_x_direction.last
        end
      end
    end
  end
  
  def hit
    destroy
  end
  
end
