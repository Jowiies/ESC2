SRC= s5c.s 
OBJ= s5c.o 
PROGRAM= s5c 

all: $(PROGRAM)

$(OBJ): $(SRC)
	sisa-as --gstabs+ -o $(OBJ) $(SRC)

$(PROGRAM): $(OBJ)
	sisa-ld -o $(PROGRAM) $(OBJ)

clean:
	rm -rf $(OBJ) $(PROGRAM)

test:
	sisa-dbg $(PROGRAM)
