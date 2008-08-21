class Enemy::Centipede < Enemy
  
  attr_accessor :head, :segment, :moving_right

  def initialize(window, segments=11)
    super(window, x, y)
    self.x = 0
    self.y = 0
    self.head = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'head.png'), 7, 8, false)
    self.segment = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'segment.png'), 7, 8, false)
    @current_head_frame = 0
    @current_segment_frame = 0
    @length = segments
    self.moving_right = true
  end
  
  def update(time)
    if moving_right? && can_move_right?
      move_right
    elsif moving_left? && can_move_left?
      move_left
    else
      move_down
    end
  end
  
  def moving_right?
    moving_right
  end

  def moving_left?
    !moving_right
  end
  
  def move_right
    self.x = self.x + 16
  end
  
  def move_left
    self.x = self.x - 16
  end
  
  def move_down
    self.moving_right = !moving_right
    self.y = self.y + 16
  end

  def can_move_right?
    @window.game.level.open?(grid_x + 1, grid_y)
  end

  def can_move_left?
    @window.game.level.open?(grid_x - 1, grid_y)
  end

  def draw
  end

  def segment_at(x, y)
  end


  class Segment < Enemy
    def initialize(window)
      super(window, x, y)
    end
  end
end
