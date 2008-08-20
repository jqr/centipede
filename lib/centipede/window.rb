class Window < Gosu::Window
  def initialize
    # double size
    super(480, 512, false)
    GosuExtras::setup_keyboard_constants(self)
  end
  
  def update
  end
  
  def draw
  end
  
  def button_down(id)
    case id
    when Gosu::Button::KbEscape
      close
    end
  end
end