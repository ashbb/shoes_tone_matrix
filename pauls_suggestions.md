Hi Satoshi,

As you would expect (as I tested the code change), v0.1a runs just fine on kubuntu 9.04. If you, or others, are not aware kubuntu is ubuntu (a Debian based distro - <http://www.ubuntu.com/> ), but using kde as the windows manager, rather than gnome.

I have some suggested changes for you to consider. These should be relatively easy to implement and I would have a go myself, but I am just not fluent enough with Shoes to do the changes quickly enough.

Changes in order of importance:

1. Save and Load of cell positions. It would be great if it was compatible with Andre Michelle's ToneMatrix save/load to clipboard as there are large number of examples in user postings to his web site.

2. Allow dynamic changes to the MIDI program. There are 128 different sounds defined by the General MIDI sound definitions (plus over 40 drum sounds for use on channel 10), although not all are included in all implementations. Let me know if you need a list with corresponding descriptions. A drop-down list would be nice! smile This would be particularly useful for anyone who has to connect the MIDI-out port to an input port to hear the sounds as this has to be done after the MIDI output port has been opened and the program change message has already been sent before the input port can be connected, so a code other than 1 (the default) has no effect. This isn't a problem for me as I can route output through a synthesizer, but it would be a nice addition to the application.

3. Visual feedback when a note is sounded. Perhaps change the colour of the cell for the duration it is playing a note.

4. I find the notes values that you have chosen a little "high" for my taste. An option for a simple key change would be nice.

5. I think I read somewhere that the original ToneMatrix uses the pentatonic scale for its note assignments as it tends to sound better. Did you use this scale to chose your note values? I'll look into this further.

------------

Posted to the Rubyist's Lounge by Paul Harris. Thanks!! :-D
