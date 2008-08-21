class Player
  def initialize(window)
    @image = Gosu::Image.new(window, File.join(GAME_DIR, 'images', 'player.png'))
    @x = window.width/2
    @y = window.height - 50
    @window = window
  end

  def draw
    @image.draw(@x - @image.width/2, @y - @image.height/2,
    		    5 # TODO: Z-order
		    )
  end

  def shoot

  end

  attr_reader :x
  attr_reader :y

  def update
    mx = @window.mouse_x
    my = @window.mouse_y
    
    @x = [[4,mx].max, @window.width - 5].min
    @y = [[@window.height - 4, my].min, @window.height - 150].max
  end
end