Shoes Tone Matrix
=================

Simple Tone Matrix on Shoes. :)

Original flash based ToneMatrix is [here](http://lab.andre-michelle.com/tonematrix).


**Note:**   
I've hacked [bleything/midiator](http://github.com/bleything/midiator/tree/master) to pick up the core MIDI interface part. :)   
I know I can use MIDIator gem with Shoes. But I want to understand the basic MIDI usage and this tiny Shoes app doesn't need the big codes.

Shoes Tone Matrix v0.1 includes the drivers for Mac and Linux. But I have no Mac and Linux... :(   
**Hope someone attempt to run v0.1 on his/her Mac or Linux and let me know what happen.** ;-)


Usage
-----

	cd shoes_tone_matrix/lib
	shoes shoes_tone_matrix.rb


Snapshot
--------
![shoes\_tone\_matrix\_snapshot.png](http://github.com/ashbb/shoes_tone_matrix/raw/master/shoes_tone_matrix_snapshot.png)

[16, 64, 256, 1024, 256, 64, 1552, 2304, 2304, 1536, 2048, 9152, 8768, 8768, 8768, 7232]

Look at [online demo](http://www.rin-shun.com/rubylearning/shoes/shoes_tone_matrix_v0.5.swf.html).

<br>

Change log
----------
Jun 21th, 2009: Merged [citizen428](http://github.com/citizen428)'s pull request and a small refactoring (v0.5b)   
Jun 20th, 2009: Added a link to an online demo. Fixed a trivial typo (v0.5a)   
Jun 19th, 2009: Improved link button style and added visual effect off/on button (v0.5)   
Jun 18th, 2009: Implemented Paul's suggestion No.2 and 3. Add CLEAR button. (v0.4)   
Jun 17th, 2009: Implemented Paul's suggestion No.1 (v0.2)   
Jun 15th, 2009: Without using MIDI number zero for Linux. (v0.1a)   
Jun 13th, 2009: First release v0.1


To do list
----------

- [Paul's suggestions](http://github.com/ashbb/shoes_tone_matrix/tree/master/pauls_suggestions.md)
- to/from clipboard ......... done!
- clear by space-key ........ done! (obsolete)
- add clear button .......... done!
- add more visual effect .... done!
- change tone type .......... done!
- change sound speed
- save tone matrix data
- add visual effect off/on button .. done!


License
-------
Distributed under the terms of the MIT license.
Look at [midiator/LICENSE](http://github.com/bleything/midiator/tree/master/LICENSE).


References
----------

- [piano](http://github.com/ashbb/piano/tree/master)
- [General Midi Programs (0 - 127)](http://www.ec.vanderbilt.edu/computermusic/musc216site/GM.Programs.html)
  General_Midi_Programs.data is created by this data.
