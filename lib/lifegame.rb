#!/usr/local/bin/ruby
# -*- coding:utf-8 -*-

class LifeGame
  attr_reader :x, :y
  attr_accessor :map

  # マップを初期化
  def initialize(map)
    @map = map
    @x = map[0].size - 1
    @y = map.size - 1
  end

  # 周辺の生きているノード数を返す
  def surround(x,y)
    arrive_num = 0
    (x-1 .. x+1).each do |n|
      (y-1 .. y+1).each do |m|
        if n < 0 || m < 0  || 
          n > @x || m > @y || 
          n==x && m==y
          next
        end
        arrive_num += 1 if @map[n][m] == 1
      end
    end
    arrive_num
  end

  # [誕生]
  def willbeBorn(n,m)
    life = 0
    life = 1 if surround(n,m) == 3
    life
  end

  # [生存]
  def servive(n,m)
    life = 1
    a = surround(n,m)
    life = 0 unless a == 2 || a == 3
    life
  end

  # [過疎] & [過密]
  def deador(n,m)
    life = 1
    a = surround(n,m)
    life = 0 if a <= 1 || a >= 4
  end

  # 次世代のArriveListを返す
  def next
    @x.times do |n|
      @y.times do |m|
        case map[n][m]
        when 0 
          map[n][m] =  willbeBorn(n,m)
        when 1
          map[n][m] = deador(n,m)
        end
      end
    end

    map
  end
    
  def display
    puts "\n*******************"
    @x.times do |n|
      @y.times do |m|
        printf "#{map[n][m]} "
      end
      printf "\n"
    end
    printf "*******************\n"
  end
end
