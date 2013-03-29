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
      (y-1 .. y+1).each do |m|
        (x-1 .. x+1).each do |n|
          if n < 0 || m < 0  ||
            n >= @width || m >= @height ||
            (n==x && m==y)
            next
          end
          arrive_num += 1 if @world[m][n] == 1
        end
      end
      arrive_num
    end

    # [誕生]
    def willbeBorn(n,m)
      (surround(n,m)==3)?1:0
    end

    # [生存]
    def servive(n,m)
      ((2..3).include?surround(n, m))?1:0
    end

    # [過疎] & [過密]
    def deadOr(n,m)
      ([0, 1, 4, 5, 6, 7, 8].include?surround(n, m))?0:1
    end

    # 次世代のworldをかえす
    def next
      @nextworld = @world.map{|x| x.clone}
      @height.times do |y|
        @width.times do |x|
          case @world[y][x]
          when 0
            @nextworld[y][x] =  willbeBorn(x, y)
          when 1
            @nextworld[y][x] = deadOr(x, y)
          end
        end
      end

      @world = @nextworld
    end

  end
end
