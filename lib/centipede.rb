require 'rubygems'
gem 'gosu'
require 'gosu'

$: << File.join(File.dirname(__FILE__))
require 'centipede/gosu_extras'
require 'centipede/window'

class Centipede
  def self.run
    Window.new.show
  end
end