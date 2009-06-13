# shoes_tone_matrix.rb
# Original ToneMatrix is here:
# http://lab.andre-michelle.com/tonematrix

info PLATFORM

require case PLATFORM
  when /mswin/ : 'midi_win'
  when /darwin/ : 'midi_mac'
  else 'midi_linux' end
  
SOUNDS = [107, 105, 103, 101, 100, 98, 96, 95, 93, 91, 89, 88, 86, 84, 83, 81]

Shoes.app :width => 520, :height => 530, :title => 'Shoes ToneMatrix v0.1' do
  background black
  sounds = []
  16.times{sounds << Array.new(16, 0)}
  
  16.times do |i|
    SOUNDS.each_with_index do |mn, j|
      x, y = i * 30 + 20, j * 30 + 20
      r = rect(x, y, 25, 25, :fill => rgb(255, 255, 255, 0.3), :curve => 5)
      r.click do
        a, b = sounds[i][j] == 0 ? [mn, 0.7] : [0, 0.3]
        sounds[i][j] = a
        r.fill = rgb(255, 255, 255, b)
      end
    end
  end
  
  midi = MIDI.new
  midi.program_change 0, 1
  
  Thread.start do
    loop do
      16.times do
        sounds.each do |mn|
          midi.play mn, 0.125
        end
      end
    end
  end
end
