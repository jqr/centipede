class Enemy
  
  attr_accessor :x, :y, :image

  def initialize(window, x, y)
    @window = window
    self.x = x
    self.y = y
  end
  
  def update
  end
  
  def draw    
  end

end