class Shot
  Z_ORDER = 4

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @@image ||= Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'shot.png'))
    @window.play_sound('shot')
  end

  def draw
    @@image.draw(@x, @y, Z_ORDER, 2, 2)
  end

  def update(ts)
    @y = @y - 20

    if off_screen?
      Game.current_game.remove_shot
    end
    
    check_for_hit(@x, @y) ||
    check_for_hit(@x, @y + 7) ||
    check_for_hit(@x, @y + 14)
  end
  
  def off_screen?
    @y < -6
  end
  
  def check_for_hit(x, y)
    Game.current_game.enemies.each do |enemy|
      if enemy.collides_with?(x, y)
        enemy.hit
        Game.current_game.remove_shot
        return true
      end
    end

    grid_x, grid_y = x / 16, y / 16
    unless Game.current_game.level.open?(grid_x, grid_y)
      health = Game.current_game.level.grid[grid_y][grid_x] - 1
      Game.current_game.level.grid[grid_y][grid_x] = health > 0 ? health : nil 
      Game.current_game.remove_shot
      return true
    end

    false
  end
end
