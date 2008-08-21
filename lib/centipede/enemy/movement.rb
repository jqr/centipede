class Enemy

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
      Game.current_game.level.open?(grid_x + 1, grid_y)
    end

    def can_move_left?
      Game.current_game.level.open?(grid_x - 1, grid_y)
    end
    
  end

end
