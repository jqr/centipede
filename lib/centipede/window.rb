require 'enemy'
require 'enemy/spider'

class Window < Gosu::Window
  attr_accessor :sounds
  
  def initialize
    # double size
    super(480, 512, false)
    GosuExtras::setup_keyboard_constants(self)
    load_sounds
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
  end
  
  def draw
    Enemy::Spider.new(self, 240, 256).draw
  end
  
  def button_down(id)
    case id
    when Gosu::Button::KbEscape
      close
    end
  end
end
