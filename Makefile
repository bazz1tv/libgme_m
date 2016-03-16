CC=g++
CPP=g++
OBJCC=g++
debug = -g
optimize = -O2

gme_CPPFLAGS=$(debug) $(optimize) -c -I. -I$(SHARED_DIR) -Igme -Wno-c++11-narrowing

LDFLAGS=-Xlinker -dylib $(debug)

# global CPP
CPP_DEFS 	= -DNDEBUG
CPPFLAGS 	= -Wno-return-type -std=c++11 $(gme_CPPFLAGS) -MMD -MP -Wno-int-to-void-pointer-cast


#### SOURCES
SOURCES=$(wildcard *.cpp) $(wildcard */*.cpp) $(wildcard */*/*.cpp)\
$(wildcard */*/*/*.cpp) $(wildcard */*/*/*/*.cpp)

# Native File Directory
MSOURCES=$(wildcard $(SHARED_DIR)*/*.m)
###

# 
OBJECTS=$(SOURCES:.cpp=.cpp.o) $(MSOURCES:.m=.m.o)
EXECUTABLE=libgme.dylib


all: $(SOURCES) $(EXECUTABLE)
	
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

%.cpp.o: %.cpp
	$(CPP) $(CPP_DEFS) $(CPPFLAGS) -c $< -o $@

%.m.o: %.m
	$(OBJCC) $(OBJCFLAGS) -c $< -o $@
	
clean:
	rm -f $(EXECUTABLE)
	find . -name "*.o" -o -name "*.d" | xargs rm -rf

install: $(EXECUTABLE)
	mkdir -p /usr/local/include/gme
	cp gme/*.h /usr/local/include/gme
	cp libgme.dylib /usr/local/lib

uninstall:
	rm -rf /usr/local/include/gme
	rm /usr/local/lib/$(EXECUTABLE)


# DO NOT DELETE THIS LINE -- make depend depends on it.
-include $(SOURCES:.cpp=.cpp.d) $(MSOURCES:.m=.m.d)
