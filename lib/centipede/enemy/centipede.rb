class Enemy::Centipede < Enemy
  attr_accessor :head, :segments, :last_move
  has_score 100

  def initialize(window, segment_size = 11)
    super(window, x, y)
    self.x = (16 * (segment_size -1))
    self.y =  0
    self.head = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'head.png'), 7, 8, false)

    @current_frame = 0

    @length = segment_size
    @just_born = true # Protect my bebby 
    self.moving_right = true
    self.segments = []
    1.upto(segment_size) do |i|
      self.segments << Enemy::Segment.new(window, self, (segment_size - (i + 1)) * 8 * 2, 0, i - 1)
    end
    
    self.last_move = 0
  end

  
  def sprite
    self.head.first
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
  end

  include Enemy::Movement

  def move_right
    super
    self.segments.each { |s| s.head_moved(:right, @just_born) }    
  end

  def move_left
    super
    self.segments.each { |s| s.head_moved(:left) }
  end

  def move_down
    super
    @just_born = false # leave the nest
    self.segments.each { |s| s.head_moved(:down) }            
  end
  
  def draw
    self.head[@current_frame].draw(x, y, Z_ORDER, 2, 2)
    @current_frame += 1
    if @current_frame >= self.head.size
      @current_frame = 0
    end 
  end

  def die
    super
    Game.current_game.next_level
  end

  def hit
    if self.segments.empty?
      self.die
      Game.current_game.next_level
    else
      self.segment_hit(self.segments.size - 1)
    end    
  end

  def segment_hit(i)
    new_centipede = self.segments.slice!(i, self.segments.size)
    new_centipede.each { |s| s.die }
    if new_centipede.size > 1 
      c = Enemy::Centipede.new(@window, 0)
      c.segments = new_centipede[2..new_centipede.size]
      c.x = new_centipede[1].x
      c.y = new_centipede[1].y
      Game.current_game.enemies << c
    end
  end
  
  def hit
    destroy
  end

end
