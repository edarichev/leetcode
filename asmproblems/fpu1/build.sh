#!/bin/bash
nasm _start.asm -f elf32 -o _start.o
ld _start.o -m elf_i386 -o exe
