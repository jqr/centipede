class Player
  def initialize(window)
    @image = Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'player.png'))
    @x = window.width/2
    @y = window.height - 50
    @window = window
  end

  def draw
    @image.draw(@x - @image.width, @y - @image.height, 0, 2, 2)
  end

  def shoot
    @window.play_sound('shoot')
    Game.current_game.add_shot(@x + @image.width, @y - 6)
  end

  def die
  end

  attr_reader :x
  attr_reader :y

  def update(time)
    mx = @window.mouse_x
    my = @window.mouse_y
    
    @x = [[@image.width, mx].max, @window.width - @image.width].min
    @y = [[@window.height - @image.height, my].min, @window.height - 150].max
  end
end
