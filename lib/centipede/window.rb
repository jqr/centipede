class Window < Gosu::Window
  attr_accessor :sounds, :images, :sound

  TILE_SIZE = 16   

  def initialize
    # double size
    super(480, 512, false)
    GosuExtras::setup_keyboard_constants(self)
    load_sounds
    @game = Game.new(self, Player.new(self))
    @game.enemies << Enemy::Spider.new(self)
    @game.enemies << Enemy::Flea.new(self)  
    self.sound = true
  end
  
  def load_sounds
    self.sounds = {}
    Dir.glob(File.join(GAME_DIR, 'sounds', '*')).each do |file|
      sounds[File.basename(file, '.wav')] = Gosu::Sample.new(self, file)
    end
  end

  def play_sound(sound)
    if sound && sounds[sound]
      sounds[sound].play
    end
  end
  
  def update
    if button_down?(Gosu::Button::MsLeft) || button_down?(Gosu::Button::KbSpace)
      Game.current_game.player.shoot
    end
    
    @game.run
  end

  def draw
    @game.draw
  end
  
  def button_down(id)
    case id
    when Gosu::Button::KbEscape
      close
    when Gosu::KbS
      self.sound = !sound
    end
  end
end
