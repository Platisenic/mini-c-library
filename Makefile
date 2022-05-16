YASM = yasm
YASMFLAGS = -f elf64 -DYASM -D__x86_64__ -DPIC
CC = gcc
CFLAGS1 = -c -g -Wall -fno-stack-protector -fPIC -nostdlib
CFLAGS2 = -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI
LD = ld
LDFLAGS1 = -shared
LDFLAGS2 = -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini
PROGS = libmini.so write1 alarm1 alarm2 alarm3 jmp1

.PHONY: all clean

libmini.so: libmini64.o libmini.o
	$(LD) $(LDFLAGS1) -o $@ $^

libmini64.o: libmini64.asm libmini.h
	$(YASM) $(YASMFLAGS) -o $@ $<

libmini.o: libmini.c libmini.h
	$(CC) $(CFLAGS1) $<

start.o: start.asm
	$(YASM) $(YASMFLAGS) -o $@ $<

write1.o: write1.c libmini.so
	$(CC) $(CFLAGS2) $<

write1: write1.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

alarm1.o: alarm1.c libmini.so
	$(CC) $(CFLAGS2) $<

alarm1: alarm1.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

alarm2.o: alarm2.c libmini.so
	$(CC) $(CFLAGS2) $<

alarm2: alarm2.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

alarm3.o: alarm3.c libmini.so
	$(CC) $(CFLAGS2) $<

alarm3: alarm3.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

jmp1.o: jmp1.c libmini.so
	$(CC) $(CFLAGS2) $<

jmp1: jmp1.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

all: $(PROGS)

clean:
	rm -f *.s *.o *.so $(PROGS)
