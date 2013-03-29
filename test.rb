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
      nextworld = lg.world
      assert_equal [[0, 1, 0], [0, 1, 0], [0, 1, 0]], nextworld

    end

    def test_next
      lg = LifeGame::World.new([[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      _nextworld = lg.next
      assert_equal [[0, 0, 0], [1, 1, 1], [0, 0, 0]], _nextworld
    end
  end
end

