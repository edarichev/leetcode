MYFILE=proc57
all : $(MYFILE)

clean : 
	rm -f $(MYFILE).o
	rm -f $(MYFILE)

$(MYFILE) : $(MYFILE).o
	gcc -g -o $(MYFILE) $(MYFILE).o -no-pie
$(MYFILE).o : $(MYFILE).asm
	nasm -f elf64 -F dwarf -o $(MYFILE).o $(MYFILE).asm
