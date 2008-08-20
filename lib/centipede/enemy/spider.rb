class Enemy::Spider < Enemy

  attr_accessor :jumping, :standing, :landing
  
  def initialize(window, x, y)
    self.jumping, self.standing, self.landing = Gosu::Image.load_tiles(window, "images/spider.png", 15, 8, false)
    super
  end
  
  def draw
    jumping.draw(x, y, 0)
  end
end