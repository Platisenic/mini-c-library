YASM = yasm
YASMFLAGS = -f elf64 -DYASM -D__x86_64__ -DPIC
CC = gcc
CFLAGS1 = -c -g -Wall -fno-stack-protector -fPIC -nostdlib
CFLAGS2 = -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI
LD = ld
LDFLAGS1 = -shared
LDFLAGS2 = -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini
PROGS = write1 alarm1 alarm2 alarm3 jmp1 jmp2
PACKNAME = 310552029_hw3

.PHONY: all clean

libmini.so: libmini64.o libmini.o
	$(LD) $(LDFLAGS1) -o $@ $^

libmini64.o: libmini64.asm libmini.h
	$(YASM) $(YASMFLAGS) -o $@ $<

libmini.o: libmini.c libmini.h
	$(CC) $(CFLAGS1) $<

start.o: start.asm
	$(YASM) $(YASMFLAGS) -o $@ $<

%.o: %.c libmini.so
	$(CC) $(CFLAGS2) $<

$(PROGS): %: %.o start.o
	$(LD) $(LDFLAGS2) -o $@ $^

all: libmini.so $(PROGS)

clean:
	rm -f core *.txt *.s *.o *.so $(PROGS) $(PACKNAME).zip

pack: clean
	mkdir -p $(PACKNAME)
	cp libmini.c libmini.h libmini64.asm start.asm Makefile $(PACKNAME)
	zip -r $(PACKNAME).zip $(PACKNAME)
	rm -rf $(PACKNAME)
