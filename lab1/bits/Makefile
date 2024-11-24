all: s4d

s4d.o: s4d.s
	sisa-as --gstabs+ -o s4d.o s4d.s

s4d: s4d.o
	sisa-ld -o s4d s4d.o

clean:
	rm -rf s4d.o s4d

test:
	sisa-dbg s4d