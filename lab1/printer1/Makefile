all: s4c

s4c.o: s4c.s
	sisa-as --gstabs+ -o s4c.o s4c.s

s4c: s4c.o
	sisa-ld -o s4c s4c.o

clean:
	rm -f *.o s4c