#!/usr/bin/env ruby
# encoding: utf-8

require 'lg_world'
require 'lg_viewer'
require 'test/unit'

module LifeGame
  class LifeGameTest < Test::Unit::TestCase

    def test_read_object
      world = []
      File.open('objects/blinker.txt') do |f|
        f.each_line do |line|
          line.chop!
          tmp = line.split(", ")
          tmp.map! {|v| v.to_i}
          world << tmp
        end
      end
      print world
      assert_equal [[0, 1, 0], [0, 1, 0], [0, 1, 0]], world

    end

    def test_surround
      lg = LifeGame::World.new([[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      a = lg.surround(1, 1)
      assert_equal 2, a
      b = lg.surround(0, 0)
      assert_equal 2, b
      c = lg.surround(0, 1)
      assert_equal 3, c
    end

    def test_willbeBorn
      lg = LifeGame::World.new([[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      a = lg.willbeBorn(0, 1)
      assert_equal 1, a
    end

    def test_compound_next
      lg = LifeGame::World.new([[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      @nextworld = lg.world.map{|x| x.clone}
      assert_equal [[0, 1, 0], [0, 1, 0], [0, 1, 0]], @nextworld
      lg.height.times do |y|
        lg.width.times do |x|
          case lg.world[y][x]
          when 0
            @nextworld[y][x] = lg.willbeBorn(x, y)
          when 1
            @nextworld[y][x] = lg.deadOr(x, y)
          end
        end
      end
      assert_equal [[0, 0, 0], [1, 1, 1], [0, 0, 0]], @nextworld
      puts ""
    end

    def test_next
      lg = LifeGame::World.new([[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      @nextworld = lg.next
      assert_equal [[0, 0, 0], [1, 1, 1], [0, 0, 0]], @nextworld
    end
  end
end

