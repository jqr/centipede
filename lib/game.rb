require 'rubygems'
require 'gosu'
require 'logger'

$: << File.join(File.dirname(__FILE__))
require 'centipede/gosu_extras'
require 'centipede/window'
require 'centipede/enemy'
require 'centipede/enemy/movement'
require 'centipede/enemy/spider'
require 'centipede/enemy/segment'
require 'centipede/enemy/centipede'
require 'centipede/enemy/flea'
require 'centipede/level'
require 'centipede/player'
require 'centipede/shot'

class Game
  attr_accessor :score, :player, :enemies, :shot, :level

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
    @current_level = 0

    self.player= player
    self.score = 0
    Game.current_game = self
    self.next_level
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

  def next_level
    @current_level += 1
    self.level = Level.new(@window, @window.width / TILE_SIZE, @window.height / TILE_SIZE, TILE_SIZE, @current_level)
    self.enemies = []
    Game.current_game = self
    centipede = Enemy::Centipede.new(@window)
    self.enemies << centipede
    self.enemies += centipede.segments
  end

  private

  def self.current_game=(g)
    @game = g
  end
end

