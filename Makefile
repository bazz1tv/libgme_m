libname = libgme_m
version = 0.0.1

prefix ?= /opt/local

CPP_DEFS += -DSMOOTH_VOLUME -DBLARGG_NONPORTABLE -DNDEBUG -DSPC_MORE_ACCURACY

ifeq ($(OS),Windows_NT)
    uname_S := Windows
else
    uname_S := $(shell uname -s)
endif

ifdef CROSS_COMPILE
	ifneq (,$(findstring i686,$(CROSS_COMPILE)))
    # 32 butt
    uname_S = Cross_Windows32
	else
	  # 64 Bit (implied from lack of i686 string)
		uname_S = Cross_Windows64
	endif
endif



ifneq (,$(filter $(uname_S),Darwin Linux Cross_Windows64 Cross_Windows32))
	CPP_DEFS += -DHAVE_STDINT_H
endif

ifeq ($(uname_S), Darwin)
	libname_ext = $(libname).dylib
    target = $(libname_ext) # .$(version)
    libname_ext_ver = $(libname_ext).$(version)

    ifeq ($(OSX_BACKSUPPORT), 1)
		OSX_BACKSUPPORT = -arch x86_64 -mmacosx-version-min=10.9 \
		-DMAC_OS_X_VERSION_MIN_REQUIRED=1090
	endif

    CPPFLAGS += $(OSX_BACKSUPPORT)
    LDFLAGS += $(OSX_BACKSUPPORT) -dynamiclib -install_name $(CURDIR)/$(libname_ext_ver)
else ifeq ($(uname_S), Linux)
	libname_ext = $(libname).so
	libname_ext_ver = $(libname_ext).$(version)
    target = $(libname_ext)
    LDFLAGS += -shared -Wl,-soname,$(libname_ext_ver)
    CPPFLAGS += -fPIC
else ifeq ($(uname_S), Cross_Windows64)
	libname_ext = $(libname).dll
	libname_ext_ver = $(libname_ext)
    target = $(libname_ext_ver)
    LDFLAGS += -shared -Wl,--out-implib,$(libname).dll.a
    #CPPFLAGS += -fPIC
    CPP_DEFS += -DLIBGME_M_EXPORTS
else ifeq ($(uname_S), Cross_Windows32)
	libname_ext = $(libname).dll
	# For some reason, on the 32bit Mingw toolchain, the DLL file when dynamically
	# compiled into SNES Tracker binaries, would reference a libgme_m.dll.0.1.1
	# file name, where on 64 bit it would refer to the final libgme_m.dll name.
	# To keep the same naming convention for the DLL names across builds,
	# I will remove the version string from the libname_ext_ver variable below.
	# That ought to fix it.
	libname_ext_ver = $(libname_ext) # .$(version)
    target = $(libname_ext_ver)
    LDFLAGS += -shared -Wl,--out-implib,$(libname).dll.a
    #CPPFLAGS += -fPIC
    CPP_DEFS += -DLIBGME_M_EXPORTS
else ifeq ($(uname_S), Windows)
    target = libgme.dll
else
	
endif

CC=$(CROSS_COMPILE)g++
CPP=$(CROSS_COMPILE)g++
OBJCC=$(CROSS_COMPILE)g++
debug = -g
optimize = -O2

gme_CPPFLAGS=$(debug) $(optimize) -c -I. -I$(SHARED_DIR) -Igme_m -Wno-c++11-narrowing

LDFLAGS += $(debug)

# global CPP
CPP_DEFS 	+=
CPPFLAGS 	+= -Wno-return-type -std=c++11 $(gme_CPPFLAGS) -MMD -MP -Wno-int-to-void-pointer-cast


#### SOURCES
SOURCES=$(wildcard *.cpp) $(wildcard */*.cpp) $(wildcard */*/*.cpp)\
$(wildcard */*/*/*.cpp) $(wildcard */*/*/*/*.cpp)

# Native File Directory
MSOURCES=$(wildcard $(SHARED_DIR)*/*.m)
###

# 
OBJECTS=$(SOURCES:.cpp=.cpp.o) $(MSOURCES:.m=.m.o)


all: $(SOURCES) $(libname_ext_ver)
	
$(libname_ext_ver): $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

# Since the Mingw32 toolchain needs to build libgme_m.dll directly, rather than
# with the version string attached first, there is no need to link to the final
# file name.
ifneq (,$(filter $(uname_S),Darwin Linux))
	ln -sf $(libname_ext_ver) $(libname_ext)
endif


%.cpp.o: %.cpp
	$(CPP) $(CPP_DEFS) $(CPPFLAGS) -c $< -o $@

%.m.o: %.m
	$(OBJCC) $(OBJCFLAGS) -c $< -o $@
	
clean:
	rm -f $(libname_ext_ver) $(libname_ext)
	find . -name "*.o" -o -name "*.d" | xargs rm -rf

# Scenario:
# Put the DLL directly into the binary folder for hotlinking
install-lib-direct: $(libname_ext_ver)
ifneq (,$(filter $(uname_S),Darwin Linux))
	mkdir -p $(prefix)
	cp $(libname_ext_ver) $(prefix)
	ln -sf $(libname_ext_ver) $(prefix)/$(libname_ext)
# else if CrossWindows64 or CrossWindows32
else ifdef CROSS_COMPILE
	mkdir -p $(prefix)
	#cp $(libname_ext_ver) $(prefix)
	cp $(libname_ext) $(prefix)
else ifeq ($(uname_S), Windows)

else

endif




install: $(libname_ext_ver)
ifneq (,$(filter $(uname_S),Darwin Linux))
	mkdir -p $(prefix)/include/gme_m
	cp gme_m/*.h $(prefix)/include/gme_m
	mkdir -p $(prefix)/lib
	cp $(libname_ext_ver) $(prefix)/lib
	ln -sf $(prefix)/lib/$(libname_ext_ver) $(prefix)/lib/$(libname_ext)
else ifeq ($(uname_S), Cross_Windows64)
	mkdir -p $(prefix)/include/gme_m
	cp gme_m/*.h $(prefix)/include/gme_m
	mkdir -p $(prefix)/lib
	cp $(libname_ext_ver) $(prefix)/bin
	cp $(libname).dll* $(prefix)/lib
	#ln -sf $(prefix)/lib/$(libname_ext_ver) $(prefix)/lib/$(libname_ext)
else ifeq ($(uname_S), Windows)
	
else
	
endif

ifeq ($(uname_S), Darwin)
	install_name_tool -id $(prefix)/lib/$(libname_ext_ver) $(prefix)/lib/$(libname_ext_ver)
endif
	

uninstall:
ifneq (,$(filter $(uname_S),Darwin Linux))
	rm -rf $(prefix)/include/gme_m
	# could make symlink point to older version of the lib if it exists
	rm $(prefix)/lib/$(libname_ext)
	rm $(prefix)/lib/$(libname_ext_ver)
else ifeq ($(uname_S), Windows)
	
else
	
endif
	


# DO NOT DELETE THIS LINE -- make depend depends on it.
-include $(SOURCES:.cpp=.cpp.d) $(MSOURCES:.m=.m.d)
