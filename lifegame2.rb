#!/usr/bin/env ruby
# encoding: utf-8

require 'lg_world'
require 'lg_viewer'
require 'curses'

world = []
input_fname = ARGV[0]
object = (File.basename(input_fname, ".txt")).upcase
File.open(input_fname) do |f|
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
  print "[ #{object} ]\t"
  print ">>START\r\n"
  lg = LifeGame::World.new(world)
  v = LifeGame::ConsolView.new(lg)
  v.visualize

  (1..150).each do |x|
    sleep(0.2)
    Curses.refresh
    Curses.clear
    print "[ #{object} ]\t"
    print "Generation #{x}\r\n"
    lg.next
    v.visualize
  end
  print ">> END"
  sleep(10)
ensure
  Curses.close_screen
end
