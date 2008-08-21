class Window < Gosu::Window
  attr_accessor :sounds, :images, :level

  TILE_SIZE = 16   

  def initialize
    # double size
    super(480, 512, false)
    self.level = Level.new(self, width/TILE_SIZE, height/TILE_SIZE, TILE_SIZE, "1")
    GosuExtras::setup_keyboard_constants(self)
    load_sounds
    @game = Game.new(self, Player.new(self))
    @game.enemies << Enemy::Spider.new(self, 240, 256)  
  end
  
  def load_sounds
    self.sounds = {}
    Dir.glob(File.join(GAME_DIR, 'sounds', '*')).each do |file|
      sounds[File.basename(file, '.wav')] = Gosu::Sample.new(self, file)
    end
  end

  def play_sound(sound)
    if sounds[sound]
      sounds[sound].play
    end
  end
  
  def update
    @game.run()
  end

  def draw
    @game.draw()
  end
  
  def button_down(id)
    case id
    when Gosu::Button::KbEscape
      close
    when Gosu::Button::MsLeft, Gosu::Button::KbSpace
      @player.shoot
    end
  end
end
