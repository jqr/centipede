class Shot

  def initialize(window, x, y)
    @x = x
    @y = y
    @@image ||= Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'shot.png'))
  end

  def draw
    @@image.draw(@x, @y, 
    		   4, # TODO: Real z-order
2, 2)
  end

  def update(ts)
    @y = @y - 1

    if @y < -6
      Game.current_game.remove_shot
    end
  end
end
