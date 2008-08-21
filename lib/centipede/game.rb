class Game

  attr_accessor :score, :player, :enemies

  def self.current_game
    @game
  end

  def initialize(window, player)
    @start_time = nil
    @end_time = nil
    @window = window
    self.player= player
    self.enemies = []
    Game.current_game = self
  end

  def start
    @start_time = Time.now.to_i
    @pause = false
  end

  def pause
    @paused = !@paused
  end

  def stop
    @end_time = Time.now
  end

  def paused?
    @paused
  end

  def in_play?
    !(@paused || @end_time)
  end

  def run(ts=nil)
    ts ||= Time.now
    if self.in_play?
      self.enemies.each do |e|
        e.update(ts)
      end
      self.player.update(ts)
    end
  end

  def draw
    self.enemies.each do |e|
      e.draw
    end
    self.player.draw
  end

  private

  def self.current_game=(g)
    @game = g
  end
  
end
