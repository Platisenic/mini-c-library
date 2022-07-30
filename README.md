# mini-c-library

## Implement mini c library to handle signals
### The API interface is the same to what we have in the standard C library.
- setjmp: prepare for long jump by saving the current CPU state. In addition, preserve the signal mask of the current process.
- longjmp: perform the long jump by restoring a saved CPU state. In addition, restore the preserved signal mask.
- signal and sigaction: setup the handler of a signal.
- sigprocmask: can be used to block/unblock signals, and get/set the current signal mask.
- sigpending: check if there is any pending signal.
- alarm: setup a timer for the current process.
- write: write to a file descriptor.
- pause: wait for signal
- sleep: sleep for a specified number of seconds
- exit: cause normal process termination
- strlen: calculate the length of the string, excluding the terminating null byte ('\0').
- functions to handle sigset_t data type: sigemptyset, sigfillset, sigaddset, sigdelset, and sigismember.

## Sample test cases
write1
```
$ make write1
gcc -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI write1.c
yasm -f elf64 -DYASM -D__x86_64__ -DPIC -o start.o start.asm
ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini -o write1 write1.o start.o
$ LD_LIBRARY_PATH=. ./write1
Hello world!
```
alarm1
```
$ make alarm1
gcc -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI alarm1.c
ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini -o alarm1 alarm1.o start.o
$ LD_LIBRARY_PATH=. ./alarm1
( 3 seconds later ...)
Alarm clock
```
alarm2
```
$ make alarm2
gcc -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI alarm2.c
ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini -o alarm2 alarm2.o start.o
$ LD_LIBRARY_PATH=. ./alarm2
( 5 seconds later ...)
sigalrm is pending.
```
alarm3
```
$ make alarm3
gcc -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI alarm3.c
ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini -o alarm3 alarm3.o start.o
$ LD_LIBRARY_PATH=. ./alarm3
^Chello
sigalrm is pending.
```
jmp1
```
$ make jmp1
gcc -c -g -Wall -fno-stack-protector -nostdlib -I. -I.. -DUSEMINI jmp1.c
ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -L. -L.. -lmini -o jmp1 jmp1.o start.o
$ LD_LIBRARY_PATH=. ./jmp1
This is function a().
This is function b().
This is function c().
This is function d().
This is function e().
This is function f().
This is function g().
This is function h().
This is function i().
This is function j().
```
## References
- [Linux System Call Table for x86 64](http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Kernel Source Code](https://elixir.bootlin.com/linux/v4.16.8/source/include/linux/syscalls.h#L603)
