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

require 'game'
