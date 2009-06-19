# shoes_tone_matrix.rb
# Original ToneMatrix is here:
# http://lab.andre-michelle.com/tonematrix

info PLATFORM

require case PLATFORM
  when /mswin/ : 'midi_win'
  when /darwin/ : 'midi_mac'
  else 'midi_linux' end
  
SOUNDS = [107, 105, 103, 101, 100, 98, 96, 95, 93, 91, 89, 88, 86, 84, 83, 81]
COLOR0, COLOR1, COLOR2 = rgb(255, 255, 255, 0.3), rgb(255, 255, 254, 0.7), rgb(135, 206, 250, 0.7)

data = IO.readlines('General_Midi_Programs.data')
data = data.reverse.collect{|e| e.chomp}
GMP = Hash[*data]

Shoes.app :width => 520, :height => 530, :title => 'Shoes ToneMatrix v0.5' do
  background black
  style Link, :stroke => white, :underline => nil, :weight => 'bold'
  style LinkHover, :stroke => gold, :fill => nil, :underline => nil
  
  @sounds, @cells, @gmp, @on = [], [], 0, false
  16.times{@sounds << Array.new(16, 0)}
  16.times{@cells << Array.new(16, 0)}
  
  f = lambda{|n| n == 1 ? 2 : f[n-1] * 2}

  DOWN_NUM = (1..16).to_a.reverse
  tmd2arr = lambda do |tmd|
    DOWN_NUM.collect{|n| ret = tmd / f[n]; tmd = tmd % f[n]; ret}.reverse
  end
  
  arr2tmd = lambda{|a| ret = 0; a.each_with_index{|e, i| ret += e * f[i+1]}; ret}
  
  self.clipboard = @sounds.collect{|sound| arr2tmd[sound]}.inspect
  
  16.times do |i|
    16.times do |j|
      x, y = i * 30 + 20, j * 30 + 20
      @cells[i][j] = rect(x, y, 25, 25, :fill => COLOR0, :curve => 5)
      @cells[i][j].click do
        a, b = @sounds[i][j] == 0 ? [1, COLOR1] : [0, COLOR0]
        @sounds[i][j] = a
        @cells[i][j].fill = b
      end
    end
  end
  
  para link('Copy'){self.clipboard = @sounds.collect{|sound| arr2tmd[sound]}.inspect}, 
    :left => 10, :top => 500
    
  para link('Paste'){
    eval('[' + self.clipboard + ']').flatten.each_with_index{|tmd, i| @sounds[i] = tmd2arr[tmd]}
    16.times do |i|
      16.times do |j|
        @cells[i][j].fill = @sounds[i][j] == 0 ? COLOR0 : COLOR1
       end
    end
    }, :left => 80, :top => 500

  para link('Clear'){
    16.times do |i|
      16.times do |j|
        @sounds[i][j] = 0
        @cells[i][j].fill = COLOR0
      end
    end
  }, :left => 150, :top => 500
  
  para link('off/on'){@on = !@on}, :left => 230, :top => 500

  list_box :items => GMP.collect{|k, v| k}.sort, :choose => 'Acoustic Grand Piano', 
    :height => 30, :left => 300, :top => 505 do |item|
      @gmp = GMP[item.text].to_i
  end
  
  sound2mn = lambda{|x| ret = []; x.each_with_index{|e, i| ret << (e.zero? ? 0 : SOUNDS[i])}; ret}
  
  chcolor = lambda do |i, c|
    @cells[i].each_with_index{|cell, j| cell.fill = c if @sounds[i][j] == 1}
  end
  
  midi = MIDI.new
  midi.program_change 0, @gmp
  
  Thread.start do
    loop do
      midi.program_change 0, @gmp
      @sounds.each_with_index do |sound, n|
        chcolor[n - 1, COLOR1]  if @on
        chcolor[n, COLOR2]  if @on
        mn = sound2mn[sound]
        mn -= [0]
        mn.empty? ? sleep(0.125) : midi.play(mn, 0.125)
      end
    end
  end
end
