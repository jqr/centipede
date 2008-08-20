require 'rubygems'
gem 'gosu'
require 'gosu'

$: << File.join(File.dirname(__FILE__))
require 'centipede/window'

class Centipede
  def self.run
    Window.new.show
  end
end