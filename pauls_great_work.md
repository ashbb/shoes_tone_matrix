Outputting to a synthesizer on Windows XP!
==========================================
Hi Satoshi,

I have re-patched sound output from Ruby and Shoes to a synthesizer on Linux (it's actually quite simple). However, I've recently built a new PC with WinXP (SP3) as there is a better variety of synthesizer related software available than on Linux. BUT, although I have been able to hear midi sound output from the various Ruby/Shoes applications (particularly, Satoshi's amazing Tone Matrix), I have been unable to route it to a synthesizer, to vary the type of sound output beyond the built-in GM synthesizer in Windows (part of the normal sound-out). UNTIL NOW. With a little help from the Ruby Midi Google group (particularly Thibaut Barrere), I have been able to patch output from Ruby/Shoes to a synthesizer! B-)

<br>

Screenshot and Sound
--------------------
![pattern1.png](http://github.com/ashbb/shoes_tone_matrix/raw/master/pattern1.png)

<br>

- [pattern1.mp3](http://github.com/ashbb/shoes_tone_matrix/raw/master/pattern1.mp3)

<br>

Explanation
-----------
**MIDIator** is a widely used Ruby library (and Gem) that allows cross-platform midi sound generation from Ruby/Shoes. Unfortunately MIDIator and Satoshi's simplified version of it manage output to Windows and Linux differently (it has to because of the way things are structured). I'm not sure how things are done on OS X, but I suspect that it is close to Linux than Windows.

When you use MIDIator to open a midi channel on Linux, it creates a raw midi port that can then be patched (connected) to an output source. On Windows, when you open a midi channel, it opens the default midi-channel, which is the built-in default midi music channel. This is the first thing that needs to be changed.

**midi_win.rb** - Here I changed the open method to accept a channel id parameter, defaulting to -1 if not supplied. The current version of midi_win.rb and corresponding MIDIator method have -1 built in, which means the default device (actually device 0 on most installations).

**shoes_tone_matrix.rb** - Here I made a few simple changes:

- I changed the width to 32 "beats" (from 16).
- I changed the note list down a couple of octaves (better to my ear)
- I removed the references and use of the GM sound programs as I was going to use a synthesizer. It is possible to control the sound banks/programs of the synth using the program_change method, but as each synthesizer is different in this respect, I decided to do it manually in the synth "on the fly".
- I removed the cell colour changing option as it slowed things down if it is used.
- I changed the open method to add the channel id 1 (see use of midi-yoke below)

**midi-yoke** - I installed this tool, which provides a number (1-16) of virtual midi-ports to be used as you wish. Selecting 1 in the open channel of the Shoes app. send the midi-output to this port.

**Synth1** - I used the soft synth Synth1, but any synth that you can select the input port on will do. I selected "midi-yoke virtual port 1" here as the midi-in and my normal sound-out for audio.

And that's it. It sounds a lot more complicated than it actually was.

<br>

More information
----------------
- the main breakthrough was the use of [MIDI Yoke](http://www.midiox.com/myoke.htm) to channel the midi-out.

- There are a great many tools out in the big wide world. One very interesting one is [KeyKit](http://nosuch.com/keykit/). This is programmed in it's own "object orient'ish" language and has literally dozens of built in tools, from drum sequencers that look like a sophisticated version of Tone Matrix to music and harmony generators. No Ruby in sight though. :-P

- One Ruby based tool that I've found for music generation is [Giles Bowkett's Archaeopteryx](http://wiki.github.com/gilesbowkett/archaeopteryx). He wrote it for HIMSELF. Use it at your peril! ;-)


------------

Posted to the Rubyist's Lounge by Paul Harris. Edited a bit and uploaded here by ashbb. :-D
