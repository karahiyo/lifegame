#!/usr/bin/env ruby
# encoding: utf-8

module LifeGame
  class ConsolView
    def initialize(world)
      @map = world
    end

    def visualize
      @map.height.times do |y|
        @map.width.times do |x|
          print @map.world[x][y]==1?"□ ":"■ "
        end
        print "\r\n"
      end
    end
  end
end
