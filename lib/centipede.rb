require 'rubygems'
require 'gosu'
require 'logger'

$: << File.join(File.dirname(__FILE__))
require 'centipede/gosu_extras'
require 'centipede/assets'
require 'centipede/window'
require 'centipede/enemy'
require 'centipede/enemy/spider'

class Centipede

  def self.logger
    @logger || Logger.new(STDOUT)
  end
  def self.run
    Window.new.show
  end
end
