class Enemy::Centipede < Enemy
  

  attr_accessor :head

  def initialize(window, segments=11)
    super(window, x, y)
    self.x = 0
    self.y = 0
    self.head = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'head.png'), 7, 8, false)

    @current_frame = 0

    @length = segments

    self.moving_right = true
    @segments = []
    1.upto(segments) do |i|
      @segments << Segment.new(window, self)
    end
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
    self.head[@current_frame].draw(x, y, 0, 2, 2)
    @current_frame += 1
    if @current_frame >= self.segment.size
      @current_frame = 0
    end    
  end



  class Segment < Enemy

    def self.segment_tiles(window)
      @segment_tiles ||= Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'body.png'), 7, 8, false)            
    end

    attr_accessor :segment
    
    def initialize(window, owner)
      super(window, x, y)

      self.segment = Segment.segment_tiles(window)
      self.moving_right = true
      @current_frame = 0
    end

    def draw
      self.segment[@current_frame].draw(x, y, 0, 2, 2)
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
        self.moving_right = !self.moving_right
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
