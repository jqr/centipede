class Enemy::Segment < Enemy

    has_score 10

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
    
    include Enemy::Movement

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



