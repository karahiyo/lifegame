#!/usr/local/bin/ruby
# -*- coding:utf-8 -*-

require 'test/unit'
require './lib/lifegame'
#require File.join(File.dirname(__FILE__), './../lib/lifegame')

class LifeGameTest < Test::Unit::TestCase

  def test_surround
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    puts lg.map.size
    a = lg.surround(1,1)
    assert_equal 3, a
    b = lg.surround(0,0)
    assert_equal 2, b
    c = lg.surround(2,2)
    assert_equal 0, c
  end

  def test_willbeBorn_1
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    a = lg.willbeBorn(1,1)
    assert_equal 1, a
  end

  def test_willbeBorn_2
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    b = lg.willbeBorn(0,2)
    assert_equal 0, b
  end

  def test_willbeBorn_3
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    c = lg.willbeBorn(2,2)
    assert_equal 0, c
  end

  def test_deadOr
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,1]])
    a = lg.deadOr(2,2)
    assert_equal 0, a
  end

  def test_next
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    #lg.display
    map = lg.next
    assert_equal [[1,1,0],[1,1,0],[0,0,0]], map
    #lg.display
  end

  def test_next_loop
    puts "*********** [ test_next_loop ] ************"
    lg = LifeGame.new([[1,1,0],[1,0,0],[0,0,0]])
    5.times do 
      #lg.display
      map = lg.next
      assert_equal [[1,1,0],[1,1,0],[0,0,0]], map
    end
    lg.position_display
  end

  def test_next_loop_2
    puts "************ [ test_next_loop 2 ] ************"
    lg = LifeGame.new([[0,1,0],[1,1,0],[0,0,1]])
    #5.times do 
      lg.display
      map = lg.next
       assert_equal [[1,1,0],[1,1,1],[0,1,0]], map
      #map = lg.next
      #assert_equal [[[1,1,0],[0,1,1],[1,1,0]]], map
    #end
  end



end

