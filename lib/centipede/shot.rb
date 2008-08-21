class Shot
  Z_ORDER = 4

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @@image ||= Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'shot.png'))
  end

  def draw
    @@image.draw(@x, @y, Z_ORDER, 2, 2)
  end

  def update(ts)
    @y = @y - 20

    if off_screen?
      Game.current_game.remove_shot
    end
    
    check_for_hit
  end
  
  def off_screen?
    @y < -6
  end
  
  def check_for_hit
    grid_x, grid_y = @x / 16, @y / 16
    unless Game.current_game.level.open?(@x / 16, @y / 16)
      health = Game.current_game.level.grid[grid_y][grid_x] - 1
      Game.current_game.level.grid[grid_y][grid_x] = health > 0 ? health : nil 
      Game.current_game.remove_shot
    end
  end
end
