#!/usr/bin/env ruby
# encoding: utf-8

require 'lg_world'
require 'lg_viewer'


lg = LifeGame::World.new([[0,1,0,0],
                          [1,1,0,0],
                          [0,0,1,0],
                          [1,0,1,0]])
v = LifeGame::ConsolView.new(lg)
v.visualize

5.times do |x|
  print "Generation #{x}\n"
  lg.next
  v.visualize
end
