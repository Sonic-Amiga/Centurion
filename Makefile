# Probe our compiler's builtin defines for WIN32 macro
WIN32 := $(shell $(CC) -E -dM - </dev/null |grep WIN32)

ifneq ($(WIN32),)
    $(info Target: Win32)
    SYS_OBJS := console_win32.o
else
    $(info Defaulting to UNIX target)
    SYS_OBJS := console.o
endif

all: centurion

CFLAGS = -g3 -Wall -pedantic

centurion: centurion.o cpu6.o disassemble.o mux.o $(SYS_OBJS)

centurion.o: centurion.c centurion.h console.h cpu6.h mux.h

console.o : console.c console.h mux.h

console_win32.o : console_win32.c console.h mux.h

cpu6.o : cpu6.c cpu6.h

disassemble.o: disassemble.h cpu6.h

mux.o : centurion.h mux.h

clean:
	rm -f centurion *.o *~

