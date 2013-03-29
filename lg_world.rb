#!/usr/local/bin/rubwidth
# -*- coding:utf-8 -*-

module LifeGame
  class World
    attr_reader :height, :width
    attr_accessor :world, :nextworld

    def initialize(world)
      @world = world
      @width = world[0].size
      @height = world.size
    end

    # 周辺の生きているノード数を返す
    def surround(x,y)
      arrive_num = 0
      (x-1 .. x+1).each do |n|
        (y-1 .. y+1).each do |m|
          if n < 0 || m < 0  ||
            n >= @height || m >= @width ||
            (n==x && m==y)
            next
          end
          arrive_num += 1 if @world[n][m] == 1
        end
      end
      arrive_num
    end

    # [誕生]
    def willbeBorn(n,m)
      life = surround(n,m)==3?1:0
    end

    # [生存]
    def servive(n,m)
      life = ((2..3).include?surround(n, m))?1:0
    end

    # [過疎] & [過密]
    def deadOr(n,m)
      life = ([0, 1, 4, 5, 6, 7, 8].include?surround(n, m))?0:1
    end

    # 次世代のArriveListを返す
    def next
      @nextworld = @world
      @height.times do |y|
        @width.times do |x|
          case @world[x][y]
          when 0
            @nextworld[x][y] =  willbeBorn(x,y)
          when 1
            @nextworld[x][y] = deadOr(x,y)
          end
        end
      end

      @world = @nextworld
    end

  end
end
