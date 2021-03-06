class Enemy::Segment < Enemy

  has_score 10

  def self.segment_tiles(window)
    @segment_tiles ||= Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'centipede', 'body.png'), 7, 8, true)
  end

  attr_accessor :segment, :segment_index, :owner

  def initialize(window, owner, sx, sy, segindex)
    super(window, sx, sy)
    self.x = sx
    self.y = sy
    self.segment = Segment.segment_tiles(window)
    self.moving_right = true
    @current_frame = 0
    self.segment_index = segindex
    self.owner = owner
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

  include Enemy::Movement

  def hit
    self.owner.segment_hit(self.segment_index)
  end
  
  def dependent_move(dir, force=false)
    check_method = "can_move_#{dir}?".to_sym
    move_method = :"move_#{dir}"
    if force || self.send(check_method)
      self.send move_method
    else
      self.move_down
    end

  end

  def head_moved(dir, force=false)
    case dir
    when :right
      self.dependent_move((self.moving_left?) ? :left : :right, force)
    else
      self.dependent_move((self.moving_right?) ? :right : :left, force)
    end
  end

  def sprite
    self.segment.first
  end


end
