CC := g++
debug := -g
CFLAGS := $(debug) -c -I. -Igme -Idemo -I/usr/local/include/SDL
LDFLAGS := $(debug) -I. -L/usr/local/lib -lsdl -lSDLMain -framework Cocoa
####
BASE_SOURCES := gme/M3u_Playlist.cpp gme/Data_Reader.cpp gme/Multi_Buffer.cpp\
gme/Blip_Buffer.cpp gme/Effects_Buffer.cpp gme/Fir_Resampler.cpp\
gme/Music_Emu.cpp gme/gme.cpp gme/Gme_File.cpp gme/Snes_Spc.cpp\
gme/Spc_Cpu.cpp gme/Spc_Dsp.cpp gme/Spc_Emu.cpp demo/Wave_Writer.cpp\
gme/Spc_Filter.cpp

BASE_OBJECTS := $(BASE_SOURCES:.cpp=.o)
###
PLAYER_SOURCES := $(BASE_SOURCES) $(wildcard player/*.cpp)
PLAYER_OBJECTS := $(PLAYER_SOURCES:.cpp=.o)
##
BASICS_SOURCES := $(BASE_SOURCES) demo/basics.c
BASICS_OBJECTS := $(BASICS_SOURCES:.cpp=.o)

#all: $(SOURCES) $(EXECUTABLE)
basics: $(BASICS_OBJECTS) $(BASICS_SOURCES)
	$(CC) $(LDFLAGS) $(BASICS_OBJECTS) -o $@

play: $(PLAYER_OBJECTS) $(PLAYER_SOURCES)
	$(CC) $(LDFLAGS) $(PLAYER_OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@
.c.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(EXECUTABLE) gme/*.o demo/*.o player/*.o
