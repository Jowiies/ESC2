SRC= s4b.s 
OBJ= s4b.o 
PROGRAM= s4b 

all: $(PROGRAM)

$(OBJ): $(SRC)
	sisa-as --gstabs+ -o $(OBJ) $(SRC)

$(PROGRAM): $(OBJ)
	sisa-ld -o $(PROGRAM) $(OBJ)

clean:
	rm -rf $(OBJ) $(PROGRAM)

test:
	sisa-dbg $(PROGRAM)
