class Enemy::Centipede < Enemy
  attr_accessor :head, :segments, :last_move
  has_score 100

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
      self.segments << Enemy::Segment.new(window, self, (segment_size - (i + 1)) * 8, 0)
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


  include Enemy::Movement


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

  def die
    super
    Game.current_game.next_level
  end


end
