diffcharscount : diffcharscount.o
	gcc -g -o diffcharscount diffcharscount.o -no-pie
diffcharscount.o : diffcharscount.asm
	nasm -f elf64 -F dwarf -o diffcharscount.o diffcharscount.asm
