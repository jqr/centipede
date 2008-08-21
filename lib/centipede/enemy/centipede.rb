class Enemy::Centipede < Enemy
  attr_accessor :head, :segments, :last_move

  def initialize(window, segment_size = 11)
    super(window, x, y)
    self.x = 8 * segment_size
    self.y = 0
    self.head = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'head.png'), 7, 8, false)


    @current_frame = 0

    @length = segment_size

    self.moving_right = true
    self.segments = []
    1.upto(segment_size) do |i|
      self.segments << Segment.new(window, self, (segment_size - (i + 1)) * 8, 0)
    end
    self.last_move = 0
  end
  
  def update(time)
    if time - last_move > 50
      if moving_right? && can_move_right?
        move_right
      elsif moving_left? && can_move_left?
        move_left
      else
        move_down
      end
      self.last_move = time
    end
    self.segments.each { |s| s.update(time) }    
  end

  module Movement
    def moving_right=(b)
      @moving_right = b
    end

    def moving_right
      @moving_right
    end

    def moving_right?
      moving_right
    end

    def moving_left?
      !moving_right
    end
    
    def move_right
      self.x = x + 16
    end
    
    def move_left
      self.x = x - 16
    end
    
    def move_down
      self.moving_right = !moving_right
      self.y = y + 16
    end

    def can_move_right?
      Game.current_game.level.open?(grid_x + 1, grid_y)
    end

    def can_move_left?
      Game.current_game.level.open?(grid_x - 1, grid_y)
    end
    
  end
  include Enemy::Centipede::Movement

  def move_right
    super
    self.segments.each { |s| s.head_moved(:right) }    
  end

  def move_left
    super
    self.segments.each { |s| s.head_moved(:left) }        
  end

  def move_down
    super
    self.segments.each { |s| s.head_moved(:down) }            
  end
  
  def draw
    self.head[@current_frame].draw(x, y, Z_ORDER, 2, 2)
    self.segments.each { |s| s.draw }
    @current_frame += 1
    if @current_frame >= self.head.size
      @current_frame = 0
    end 
  end



  class Segment < Enemy

    def self.segment_tiles(window)
      @segment_tiles ||= Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'body.png'), 7, 8, true)
    end

    attr_accessor :segment
    
    def initialize(window, owner, sx, sy)
      super(window, sx, sy)
      self.x = sx
      self.y = sy
      self.segment = Segment.segment_tiles(window)
      self.moving_right = true
      @current_frame = 0
    end

    def draw
      self.segment[@current_frame].draw(x, y, Z_ORDER, 2, 2)
      @current_frame += 1
      if @current_frame >= self.segment.size
        @current_frame = 0
      end
    end

    def update(time)
      
    end
    
    include Enemy::Centipede::Movement

    def forced_move(dir)
      check_method = "can_move_#{dir}?".to_sym
      move_method = :"move_#{dir}"
      if self.send check_method
        self.send move_method
      else
        self.move_down
      end
    end

    def head_moved(dir)
      case dir
      when :right
        self.forced_move((self.moving_left?) ? :left : :right)                
      else
        self.forced_move((self.moving_right?) ? :right : :left)        
      end
    end

  end
end
