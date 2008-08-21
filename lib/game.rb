require 'rubygems'
require 'gosu'
require 'logger'

$: << File.join(File.dirname(__FILE__))
require 'centipede/gosu_extras'
require 'centipede/window'
require 'centipede/enemy'
require 'centipede/enemy/spider'
require 'centipede/enemy/centipede'
require 'centipede/level'
require 'centipede/player'
require 'centipede/shot'

class Game
  attr_accessor :score, :player, :enemies, :shot, :level, :centipedes

  TILE_SIZE = 16

  def self.logger
    @logger || Logger.new(STDOUT)
  end
  
  def self.run
    Window.new.show
  end

  def self.current_game
    @game
  end

  def initialize(window, player)
    
    @start_time = nil
    @end_time = nil
    @window = window

    self.level = Level.new(@window, @window.width / TILE_SIZE, @window.height / TILE_SIZE, TILE_SIZE, "1")

    self.player= player
    self.enemies = []
    self.score = 0
    Game.current_game = self
    self.centipedes = [Enemy::Centipede.new(@window)]
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
    ts ||= Gosu::milliseconds
    if self.in_play?
      self.centipedes.each do |c|
        c.update(ts)
      end
      self.enemies.each do |e|
        e.update(ts)
      end
      shot.update(ts) if shot
      self.player.update(ts)
    end
  end

  def draw
    level.draw
    shot.draw if shot
    self.centipedes.each do |c|
      c.draw
    end
    self.enemies.each do |e|
      e.draw
    end
    self.player.draw
  end
  
  def add_shot(x, y)
    self.shot = Shot.new(@window, x, y) unless shot
  end

  def remove_shot
    self.shot = nil
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

