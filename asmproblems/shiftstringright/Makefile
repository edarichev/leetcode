shiftstringright : shiftstringright.o
	gcc -g -o shiftstringright shiftstringright.o -no-pie
shiftstringright.o : shiftstringright.asm
	nasm -f elf64 -F dwarf -o shiftstringright.o shiftstringright.asm
