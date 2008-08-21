class Player
  def initialize(window)
    @image = Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'player.png'))
    @x = window.width/2
    @y = window.height - 50
    @window = window
  end

  def draw
    @image.draw(@x - @image.width/2, @y - @image.height/2, 0, 2, 2)
  end

  def shoot

  end

  attr_reader :x
  attr_reader :y

  def update
    mx = @window.mouse_x
    my = @window.mouse_y
    
    @x = [[@image.width * 2, mx].max, @window.width - @image.width * 2].min
    @y = [[@window.height - @image.height * 2, my].min, @window.height - 150].max
  end
end