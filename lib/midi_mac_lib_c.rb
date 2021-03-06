# midi_mac_lib_c.rb
require 'dl/import'
ON  = 0x90
OFF = 0x80
PC  = 0xc0

module C
  extend DL::Importable
  dlload '/System/Library/Frameworks/CoreMIDI.framework/Versions/Current/CoreMIDI'

  extern "int MIDIClientCreate( void*, void*, void*, void* )"
  extern "int MIDIClientDispose( void* )"
  extern "int MIDIGetNumberOfDestinations()"
  extern "void* MIDIGetDestination( int )"
  extern "int MIDIOutputPortCreate( void*, void*, void* )"
  extern "void* MIDIPacketListInit( void* )"
  extern "void* MIDIPacketListAdd( void*, int, void*, int, int, int, void* )"
  extern "int MIDISend( void*, void*, void* )"
end

module CF
  extend DL::Importable
  dlload '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'

  extern "void* CFStringCreateWithCString( void*, char*, int )"
end
