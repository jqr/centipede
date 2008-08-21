class Game

  attr_accessor :score, :player, :enemies, :shots

  def self.current_game
    @game
  end

  def initialize(window, player)
    @start_time = nil
    @end_time = nil
    @window = window
    self.player= player
    self.enemies = []
    self.shots = []
    self.player = player
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
      self.shots.each do |s|
        s.update(ts)
      end
      self.enemies.each do |e|
        e.update(ts)
      end
      self.player.update(ts)
    end
  end

  def draw
    self.shots.each do |s|
      s.draw
    end
    self.enemies.each do |e|
      e.draw
    end
    self.player.draw
  end

  def remove(*objs)
    objs.each do |o|
      case o
      when Shot
        self.shots.delete(o)
      when Enemy
        self.enemies.delete(o)
      when Player
        self.stop
      end
    end
  end

  private

  def self.current_game=(g)
    @game = g
  end
  
end
