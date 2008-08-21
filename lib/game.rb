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
  attr_accessor :score, :player, :enemies, :shots, :level, :centipedes

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
    self.shots = []
    self.score = 0
    Game.current_game = self
    @shots = []
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
    ts ||= Time.now
    if self.in_play?
      self.shots.each do |s|
        s.update(ts)
      end
      self.enemies.each do |e|
        e.update(ts)
      end
      self.player.update(ts)
      self.shots.each do |s|
        s.update(ts)
      end
    end
  end

  def draw
    level.draw
    self.shots.each do |s|
      s.draw
    end
    self.enemies.each do |e|
      e.draw
    end
    self.player.draw
    self.shots.each do |s|
      s.draw
    end
  end
  
  def add_shot(x,y)
    @shots.unshift(Shot.new(@window,x,y))
  end

  def remove_shot(shot)
    @shots.reject! { |s| s == shot }
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
