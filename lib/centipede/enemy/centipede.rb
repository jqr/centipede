class Enemy::Centipede < Enemy
  
<<<<<<< HEAD:lib/centipede/enemy/centipede.rb
  attr_accessor :head, :segment

  def initialize(window, segments=11)
    super(window, x, y)
    self.x = 0
    self.y = 0
    self.head = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'head.png'), 7, 8, false)
    self.segment = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'segment.png'), 7, 8, false)
    @current_head_frame = 0
    @current_segment_frame = 0
    @length = segments
  end
  
  def update(time)
    
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
