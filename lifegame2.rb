#!/usr/bin/env ruby
# encoding: utf-8

require 'lg_world'
require 'lg_viewer'
require 'curses'

world = []
File.open(ARGV[0]) do |f|
  f.each_line do |line|
    line.chop!
    tmp = line.split(", ")
    tmp.map! {|v| v.to_i}
    world << tmp
  end
end


Curses.init_screen
Curses.refresh
Curses.clear
begin
  print "START\r\n"
  lg = LifeGame::World.new(world)
  v = LifeGame::ConsolView.new(lg)
  v.visualize

  100.times do |x|
    sleep(1)
    Curses.refresh
    Curses.clear
    print "Generation #{x}\r\n"
    lg.next
    v.visualize
  end
ensure
  Curses.close_screen
end
