#!/usr/local/bin/ruby
# -*- coding:utf-8 -*-

class LifeGame
  attr_reader :x, :y
  attr_accessor :map
  attr_accessor :nextmap

  # �}�b�v��������
  def initialize(map)
    @map = map
    @nextmap
    @x = map[0].size - 1 
    @y = map.size - 1
  end

  # ���ӂ̐����Ă���m�[�h����Ԃ�
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

  # [�a��]
  def willbeBorn(n,m)
    life = 0
    life = 1 if surround(n,m) == 3
    life
  end

  # [����]
  def servive(n,m)
    life = 1
    a = surround(n,m)
    life = 0 unless a == 2 || a == 3
    life
  end

  # [�ߑa] & [�ߖ�]
  def deadOr(n,m)
    life = 1
    a = surround(n,m)
    life = 0 if a <= 1 || a >= 4  
    life
  end

  # !New! [�ߑa] & [�ߖ�] 
  def nextdeadOr(n,m)
    life = 0
    a = surround(n,m)
    life = 1 if a <= 1 || a >= 4
    life
  end

  # �������ArriveList��Ԃ�
  def next
    #nextmap = Array.new(@x).map{ Array.new(@x,0)} 
    #(0..@x).each do |n|
    #  (0..@y).each do |m|
    #    nextmap[n][m] = 0
    #  end
    #end
    
    nextmap = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
    (0..@x).each do |n|
      (0..@y).each do |m|
        case map[n][m]
        when 0 
          nextmap[n][m] =  willbeBorn(n,m)
        when 1
          nextmap[n][m] = nextdeadOr(n,m)
        end
      end
    end
    
    # map��nextmap�Ŕr�������nextmap��
    (0..@x).each do |n|
      (0..@y).each do |m|
        map[n][m] = map[n][m] ^ nextmap[n][m]
      end
    end

    map
  end

  def renew
    (0..@x).each do |n|
      (0..@y).each do |m|
        nextmap[n][m] = 0
      end
    end
    nextmap
  end
    
  def display
    puts "\n*******************"
    (0..@x).each do |n|
      (0..@y).each do |m|
        printf "#{map[n][m]} "
      end
      printf "\n"
    end
    printf "*******************\n"
  end

  def position_display
    puts "\n*******************"
      (0..@x).each do |n|
        (0..@y).each do |m|
          printf "#{n},#{m} "
      end
      printf "\n"
    end
    printf "*******************\n"
  end
    
end
