palindrom : palindrom.o
	gcc -g -o palindrom palindrom.o -no-pie
palindrom.o : palindrom.asm
	nasm -f elf64 -F dwarf -o palindrom.o palindrom.asm
