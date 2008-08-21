class Shot
  Z_ORDER = 4

  attr_reader :x, :y

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
    
    check_for_hit(@x, @y, 2, 7) 
  end
  
  def off_screen?
    @y < -6
  end
  
  def check_for_hit(x, y, steps = 0, step_size = 7)
    Game.current_game.enemies.each do |enemy|
      enemy_hit = false
      for i in (0..steps)
        if !enemy_hit && enemy.collides_with?(x, y + (i*step_size))
          enemy.hit
          enemy_hit = true
          break
        end
      end
      if enemy_hit
        Game.current_game.remove_shot
        return true
      end
    end

    for i in (0..steps)
      grid_x, grid_y = x / 16, (y + i * step_size) / 16
      if Game.current_game.level.grid[grid_y]
        unless Game.current_game.level.open?(grid_x, grid_y)
          health = Game.current_game.level.grid[grid_y][grid_x] - 1
          Game.current_game.level.grid[grid_y][grid_x] = health > 0 ? health : nil 
          Game.current_game.remove_shot
          return true
        end
      end      
    end

    
    false
  end
end
