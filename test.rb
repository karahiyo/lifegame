#!/usr/bin/env ruby
# encoding: utf-8

require 'lg_world'
require 'lg_viewer'
require 'test/unit'

module LifeGame
  class LifeGameTest < Test::Unit::TestCase

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
          print "[#{lg.world[y][x]} (#{x}, #{y})]\n"
          case lg.world[y][x]
          when 0
            print "{case 0}", lg.world[y][x], "=> "
            @nextworld[y][x] = lg.willbeBorn(x, y)
            print @nextworld[y][x], "\n"
          when 1
            print "{case 1}", lg.world[y][x], "=>"
            @nextworld[y][x] = lg.deadOr(x, y)
            print @nextworld[y][x], "\n"
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

