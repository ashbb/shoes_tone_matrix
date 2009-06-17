# shoes_tone_matrix.rb
# Original ToneMatrix is here:
# http://lab.andre-michelle.com/tonematrix

info PLATFORM

require case PLATFORM
  when /mswin/ : 'midi_win'
  when /darwin/ : 'midi_mac'
  else 'midi_linux' end
  
SOUNDS = [107, 105, 103, 101, 100, 98, 96, 95, 93, 91, 89, 88, 86, 84, 83, 81]

Shoes.app :width => 520, :height => 530, :title => 'Shoes ToneMatrix v0.2' do
  background black
  sounds, nodes = [], []
  16.times{sounds << Array.new(16, 0)}
  16.times{nodes << Array.new(16, 0)}
  
  f = lambda{|n| n == 1 ? 2 : f[n-1] * 2}

  DOWN_NUM = (1..16).to_a.reverse
  tmd2arr = lambda do |tmd|
    DOWN_NUM.collect{|n| ret = tmd / f[n]; tmd = tmd % f[n]; ret}.reverse
  end
  
  arr2tmd = lambda{|a| ret = 0; a.each_with_index{|e, i| ret += e * f[i+1]}; ret}
  
  self.clipboard = sounds.collect{|sound| arr2tmd[sound]}.inspect
  
  16.times do |i|
    16.times do |j|
      x, y = i * 30 + 20, j * 30 + 20
      nodes[i][j] = rect(x, y, 25, 25, :fill => rgb(255, 255, 255, 0.3), :curve => 5)
      nodes[i][j].click do
        a, b = sounds[i][j] == 0 ? [1, 0.7] : [0, 0.3]
        sounds[i][j] = a
        nodes[i][j].fill = rgb(255, 255, 255, b)
      end
    end
  end
  
  para link('To clipboard'){self.clipboard = sounds.collect{|sound| arr2tmd[sound]}.inspect}, 
    :left => 30, :top => 500
    
  para link('From clipboard'){
    eval('[' + self.clipboard + ']').flatten.each_with_index{|tmd, i| sounds[i] = tmd2arr[tmd]}
    16.times do |i|
      16.times do |j|
        nodes[i][j].fill = rgb(255, 255, 255, sounds[i][j] == 0 ? 0.3 : 0.7)
       end
    end
    }, :left => 200, :top => 500
  
  keypress do |key|
    16.times do |i|
      16.times do |j|
        sounds[i][j] = 0
        nodes[i][j].fill = rgb(255, 255, 255, 0.3)
      end
    end if key == ' '
  end

  sound2mn = lambda{|x| ret = []; x.each_with_index{|e, i| ret << (e.zero? ? 0 : SOUNDS[i])}; ret}
  
  midi = MIDI.new
  midi.program_change 0, 1
  
  Thread.start do
    loop do
      16.times do
        sounds.each do |sound|
          mn = sound2mn[sound]
          mn -= [0]
          mn.empty? ? sleep(0.125) : midi.play(mn, 0.125)
        end
      end
    end
  end
end
