class Enemy::Flea < Enemy
  has_score 200
  
  def initialize(window, level)
    super(window, x, y)
    start_position!(window, level)
    @current_sprite = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'flea.png'), 15, 8, false)
    @wait = 0
    @window.play_sound('flea')
    @level = level
  end

  def start_position!(window, level)

  end
end
