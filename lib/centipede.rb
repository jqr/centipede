require 'rubygems'
require 'gosu'

$: << File.join(File.dirname(__FILE__))
require 'centipede/gosu_extras'
require 'centipede/window'

RESOURCE_PATH = File.join(File.dirname(__FILE__), '..')
class Centipede
  def self.run
    Window.new.show
  end
end